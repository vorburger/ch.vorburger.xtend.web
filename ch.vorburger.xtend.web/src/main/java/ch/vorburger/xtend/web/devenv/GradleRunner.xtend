package ch.vorburger.xtend.web.devenv

import java.io.File
import ch.vorburger.exec.ManagedProcessBuilder

class GradleRunner {

    def boolean runGradle(File directory, String tasks) {
        val gradlew = new File(directory, "gradlew")
        if (!gradlew.exists)
            throw new IllegalStateException("No Gradle Wrapper (gradlew) in directory: " + directory)
        val managedProcess = (new ManagedProcessBuilder(gradlew) => [
            workingDirectory = directory            
            addArgument(tasks)
        ]).build()
        managedProcess.start
        managedProcess.waitForExitMaxMsOrDestroy(5000)
        return managedProcess.exitValue == 0
    }

}
