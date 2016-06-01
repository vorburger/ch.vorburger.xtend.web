package ch.vorburger.xtend.web.devenv

import java.io.File
import ch.vorburger.exec.ManagedProcessBuilder

class GradleRunner {

    def boolean runGradle(File directory, String... arguments) {
        val gradlew = new File(directory, "gradlew")
        if (!gradlew.exists)
            throw new IllegalStateException("No Gradle Wrapper (gradlew) in directory: " + directory)
        val managedProcess = (new ManagedProcessBuilder(gradlew) => [
            workingDirectory = directory
            for (arg : arguments)
            addArgument(arg)
        ]).build()
        managedProcess.start
        managedProcess.waitForExitMaxMsOrDestroy(30000) // 30s seems long, but 5-10s are often required
        return managedProcess.exitValue == 0
    }

}
