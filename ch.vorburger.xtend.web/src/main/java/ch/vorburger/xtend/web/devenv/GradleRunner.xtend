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
        managedProcess.waitForExitMaxMsOrDestroy(120000) // 2' seems very long, but 5-10s are often required locally, and more than 30s on first install (with Downloads) on OpenShift
        return managedProcess.exitValue == 0
    }

}
