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
import org.eclipse.jetty.util.component.LifeCycle.Listener
import org.eclipse.jetty.util.component.LifeCycle
import org.eclipse.jetty.webapp.WebAppContext
import org.eclipse.jetty.webapp.WebInfConfiguration
import org.slf4j.LoggerFactory
import com.google.common.base.Optional

/**
 * This program starts an HTTP server for testing the web integration of your DSL.
 * Just execute it and point a web browser to http://localhost:8080/.
 */
class ServerLauncher {
    val static logger = LoggerFactory.getLogger(ServerLauncher)
    
    def static void main(String[] args) {
        val ip = if (args.size > 0) args.get(0) else 'localhost'
        val port = if (args.size > 1) Integer.valueOf(args.get(1)) else 8080
        val server = new ServerLauncher().launch(ip, port)
        if (server.isPresent) {
            new Thread [
                logger.info('Press enter to stop the server...')
                val key = System.in.read
                if (key !== -1) {
                    server.get.stop
                } else {
                    logger.warn('Console input is not available. In order to stop the server, you need to cancel process manually.')
                }
            ].start
            server.get.join
        } else {
            System.exit(1)
        }
    }
    
    def Optional<Server> launch(String ip, int port) {
        val server = new Server(new InetSocketAddress(ip, port))
        val webAppContext = new WebAppContext => [
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
            
            // this is great: if WAR couldn't start, don't swallow cause, but propagate!
            servletHandler.startWithUnavailable = false
        ]
        server.handler = webAppContext
        server.addLifeCycleListener(new Listener() {

            override lifeCycleFailure(LifeCycle event, Throwable cause) {
                logger.error("Failed to start server (lifeCycleFailure)", cause)
            }

            override lifeCycleStarted(LifeCycle event) {
                logger.info('Server started on ' + server.getURI)
            }

            override lifeCycleStarting(LifeCycle event) {
                logger.info('Server starting...')
            }

            override lifeCycleStopped(LifeCycle event) {
                logger.info('Server stopped.')
            }

            override lifeCycleStopping(LifeCycle event) {
                logger.info('Server stopping...')
            }

        })
        server.start
        if (!webAppContext.isAvailable() || webAppContext.isFailed() || !webAppContext.isRunning()
                || !webAppContext.isStarted() || server.isFailed() || server.isFailed() || !server.isRunning()
                || !server.isStarted()) {
            // We must (try to) STOP the server, otherwise the forked background
            // thread keeps running, and the JVM won't exit (e.g. in JUnit
            // Tests)
            server.stop();
            if (webAppContext.getUnavailableException() != null) {
                logger.error("Failed to start server (webAppContext)", webAppContext.getUnavailableException())
            } else {
                logger.error("Failed to start server (webAppContext; no unavailableException, see details on STDOUT & WebAppContext WARN log..)")
            }
            return Optional.absent
        } else {
            return Optional.of(server)
        }
    }
}
