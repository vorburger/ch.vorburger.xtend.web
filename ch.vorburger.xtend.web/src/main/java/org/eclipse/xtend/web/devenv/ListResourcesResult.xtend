package org.eclipse.xtend.web.devenv

import java.util.List
import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtext.web.server.IServiceResult

@Data
class ListResourcesResult implements IServiceResult {

    List<String> resouceIDs

}
