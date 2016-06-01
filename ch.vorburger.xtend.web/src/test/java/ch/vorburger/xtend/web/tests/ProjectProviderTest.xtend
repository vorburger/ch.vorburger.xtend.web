package ch.vorburger.xtend.web.tests

import ch.vorburger.xtend.web.ExamplesLibrary
import java.io.File
import org.junit.Assert
import org.junit.Test
import com.google.inject.Guice

class ProjectProviderTest {
    
    @Test def testExamplesLibrary() {
        val injector = Guice.createInjector()
        val pp = injector.getInstance(ExamplesLibrary)
        val p = pp.getProject("test")
        Assert.assertTrue(new File(p.baseDir, ".classpath").exists)
    }
    
}