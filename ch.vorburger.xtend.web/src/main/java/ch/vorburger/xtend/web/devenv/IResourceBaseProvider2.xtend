package ch.vorburger.xtend.web.devenv

import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider

interface IResourceBaseProvider2 extends IResourceBaseProvider {

    def Iterable<String> getResourceIDs(String baseResourcePath)

}
