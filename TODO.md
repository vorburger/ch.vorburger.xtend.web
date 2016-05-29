
- [ ] XtendWebSetup Project location configuration more flexible
- [ ] remove ExamplesLibrary, make file save optional so that demo.examples never get overridden


- [ ] HOST it somewhere!
        sep. build/deploy/start, so that failing builds don't destroy what's running.
            nohup java, not gradle
            fat jar? 
        working??
        logging
            https://access.redhat.com/documentation/en-US/OpenShift_Enterprise/2/html/Cartridge_Specification_Guide/chap-Enabling_Logshifter.html
            logback
        OpenShift Jenkins SOOOO slow / unreliable - why??
        publish new gradle application template

- [ ] src/main/webapp/index.html gen. from src/main/java/**/*.xtend (statically, build; not run-time, for CDN..)
- [ ] separate project xtend.web.lib VS xtend.web.demo (allows me to CUSTOMIZE the UI, yet share some (JS) code) 
- [ ] work without hard-coded HelloWorld.xtend

- [ ] separate project xtend.web.generator: Set up more configurable allow another project to use this without XtendServiceDispatcher and code generation shown in UI

- [ ] multi user

- [ ] security

- [ ] auto format



- [ ] generalize ExamplesLibrary - make it a def init() of Project (for MCS it will just put a build.gradle)
 
- [ ] dirty indicator?

- [ ] multi project, and add all files from ExamplesLibrary

- [ ] XtendServiceDispatcher getJava2XtendService hasTextInput ?

- [ ] XtendServiceDispatcher.xtend getJava2XtendService "it would be better to create a new service for this instead of changing the semantics of the original generator service."
        https://github.com/eclipse/xtext/pull/1002
