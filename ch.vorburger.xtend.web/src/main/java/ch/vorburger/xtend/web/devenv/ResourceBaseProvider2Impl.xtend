package ch.vorburger.xtend.web.devenv

import com.google.inject.Inject
import org.apache.commons.io.FileUtils
import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider
import org.eclipse.xtext.web.server.InvalidRequestException
import org.eclipse.emf.common.util.URI
import java.io.File
import com.google.inject.Singleton

@Singleton
class ResourceBaseProvider2Impl implements IResourceBaseProvider, IResourceBaseProvider2 {

    @Inject ProjectProvider projectProvider

    override getResourceIDs(String baseResourcePath) {
        val resourceBase = projectProvider.getProject(baseResourcePath).limitedSourceDirectory
        FileUtils.listFiles(resourceBase, Project.xtendExtensions, true).map [
            resourceBase.toPath.relativize(it.toPath).toString
        ]
    }
    
    override getFileURI(String resourceId) {
        if (resourceId.contains('..'))
            throw new InvalidRequestException.InvalidParametersException('Invalid resource path: ' + resourceId)
        val resourceBase = projectProvider.getProject(resourceId).limitedSourceDirectory
        // TODO when resourceId includes user/project prefix, then it will have to be adjusted here
        URI.createFileURI(new File(resourceBase, resourceId).toString())
    }

}
