package ch.vorburger.xtend.web.devenv

interface ProjectProvider {
    
    def Project getProject(String resourceId)
    
}