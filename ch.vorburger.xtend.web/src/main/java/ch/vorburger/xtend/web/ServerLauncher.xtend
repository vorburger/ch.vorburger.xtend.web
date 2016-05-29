/*******************************************************************************
 * Copyright (c) 2010-2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ch.vorburger.xtend.web

import java.net.InetSocketAddress
import org.eclipse.jetty.server.Server
import org.eclipse.jetty.util.log.Slf4jLog
import org.eclipse.jetty.webapp.WebAppContext
import org.eclipse.jetty.webapp.WebInfConfiguration

/**
 * This program starts an HTTP server for testing the web integration of your DSL.
 * Just execute it and point a web browser to http://localhost:8080/.
 */
class ServerLauncher {
    def static void main(String[] args) {
        val ip = if (args.size > 0) args.get(0) else 'localhost'
        val port = if (args.size > 1) Integer.valueOf(args.get(1)) else 8080
        val server = new Server(new InetSocketAddress(ip, port))
        server.handler = new WebAppContext => [
            resourceBase = 'src/main/webapp'
            welcomeFiles = #["index.html"]
            contextPath = "/"
//			configurations = #[
//				new AnnotationConfiguration,
//				new WebXmlConfiguration,
//				new WebInfConfiguration,
//				new MetaInfConfiguration
//			]
            addServlet(XtendServlet, XtendServlet.URL_PATTERNS)
            setAttribute(WebInfConfiguration.CONTAINER_JAR_PATTERN, // '.*/org\\.eclipse\\.xtend\\.web/.*,' + 
            '.*/org\\.eclipse\\.xtext\\.web.*,.*/org\\.webjars.*')
        ]
        val log = new Slf4jLog(ServerLauncher.name)
        try {
            server.start
            log.info('Server started ' + server.getURI + '...')
            new Thread [
                log.info('Press enter to stop the server...')
                val key = System.in.read
                if (key !== -1) {
                    server.stop
                } else {
                    log.warn(
                        'Console input is not available. In order to stop the server, you need to cancel process manually.')
                }
            ].start
            server.join
        } catch (Exception exception) {
            log.warn(exception.message)
            System.exit(1)
        }
    }
}
