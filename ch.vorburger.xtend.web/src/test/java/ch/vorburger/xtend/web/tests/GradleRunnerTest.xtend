package ch.vorburger.xtend.web.tests

import org.junit.Test
import org.apache.commons.io.FileUtils
import java.nio.file.Files
import ch.vorburger.xtend.web.devenv.GradleWrapperWriter
import ch.vorburger.xtend.web.devenv.GradleRunner
import org.junit.Assert
import ch.vorburger.exec.ManagedProcessException

class GradleRunnerTest {

    @Test def void runGradleOK() {
        Assert.assertTrue(runTempGradle("--version"))
    }

    @Test(expected=ManagedProcessException) def void runGradleNOK() {
        runTempGradle("BADBAD")
    }

    def protected runTempGradle(String tasks) {
        val tempDir = Files.createTempDirectory(class.name).toFile
        try {
            new GradleWrapperWriter().installGradleWrapper(tempDir)
            return new GradleRunner().runGradle(tempDir, tasks)
        } finally {
            FileUtils.deleteQuietly(tempDir);
        }
    }
}
