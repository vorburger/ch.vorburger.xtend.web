package ch.vorburger.xtend.web.devenv

import org.eclipse.xtext.web.server.persistence.ResourcePersistenceService
import org.eclipse.xtext.web.server.persistence.IServerResourceHandler
import org.eclipse.xtext.web.server.IServiceContext
import org.eclipse.xtext.web.server.InvalidRequestException
import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider
import com.google.inject.Inject
import java.io.File
import com.google.common.io.Files
import com.google.common.base.Charsets

class AutoRefreshingResourcePersistenceService extends ResourcePersistenceService {
    
    @Inject IResourceBaseProvider resourceBaseProvider;
    
    override load(String resourceId, IServerResourceHandler resourceHandler, IServiceContext serviceContext) throws InvalidRequestException {
        var result = super.load(resourceId, resourceHandler, serviceContext)
        val uri = resourceBaseProvider.getFileURI(resourceId)
        if (uri.isFile) {
            val file = new File(uri.toFileString)
            // NOTE: Hard-coded UTF-8 isn't right.. it would have to match the encoding used to read the files in the ResourceSet - but where to find that??
            val fileContent = Files.toString(file, Charsets.UTF_8)
            if (!result.fullText.equals(fileContent)) {
                result = revert(resourceId, resourceHandler, serviceContext)
            }
        }
        return result
    }
    
}