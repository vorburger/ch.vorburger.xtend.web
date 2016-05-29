package ch.vorburger.xtend.web.devenv

import ch.vorburger.xtend.web.ExamplesLibrary
import org.eclipse.xtext.service.AbstractGenericModule
import org.eclipse.xtext.web.server.model.IWebResourceSetProvider

class WebDevEnvModule extends AbstractGenericModule {

    def ProjectProvider bindProjectProvider() {
        // or... new Project(new File("/home/vorburger/dev/Minecraft/SwissKnightMinecraft/SpongePowered/MyFirstSpongePlugIn"), "src/main/java", "ch/vorburger/minecraft/michaelpapa7")
        new ExamplesLibrary
    }

    def IWebResourceSetProvider bindIWebResourceSetProvider() {
        new WebDevEnvResourceSetProvider()
    }

}
