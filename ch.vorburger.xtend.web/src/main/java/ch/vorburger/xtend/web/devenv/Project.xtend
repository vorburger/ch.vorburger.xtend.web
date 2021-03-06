package ch.vorburger.xtend.web.devenv

import java.io.File
import org.eclipse.xtend.lib.annotations.Data

@Data class Project {

    static public val String[] xtendExtensions = #["xtend"]

    File baseDir
    String sourceDir
    String sourceDirLimited

    def getLimitedSourceDirectory() {
        new File(baseDir, sourceDir + "/" + sourceDirLimited)
    }

    def getSourceDirectory() {
        new File(baseDir, sourceDir)
    }
}
