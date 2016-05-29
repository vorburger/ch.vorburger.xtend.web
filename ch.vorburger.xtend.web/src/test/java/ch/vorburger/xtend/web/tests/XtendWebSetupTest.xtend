package ch.vorburger.xtend.web.tests

import ch.vorburger.xtend.web.XtendWebSetup
import com.google.inject.Provider
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import org.junit.Test
import java.util.List

class XtendWebSetupTest {
    
    // TODO This should Xtext test runner, or memento directly, to clean up EMF static in teardown
    
    @Test def void testXtendWebSetup() {
        val List<ExecutorService> executorServices = newArrayList
        val Provider<ExecutorService> executorServiceProvider = [
            Executors.newCachedThreadPool => [executorServices += it]
        ]
        new XtendWebSetup(executorServiceProvider).createInjectorAndDoEMFRegistration()
    }
    
}
