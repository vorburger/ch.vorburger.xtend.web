- [ ] make it work again, why broken? Better error next time..

- [ ] reformat all sources? what convention does Xtext use - tabs or spaces, how many?  Set up Xtext Oomph workspace...

- [ ] CLI build must work.. see https://bugs.eclipse.org/bugs/show_bug.cgi?id=491400: ../../gradlew build => NOK :(

- [ ] HOST it somewhere

- [ ] src/main/webapp/index.html gen. from src/main/java/**/*.xtend (statically, build; not run-time, for CDN..)
- [ ] separate project xtend.web.lib VS xtend.web.demo (allows me to CUSTOMIZE the UI, yet share some (JS) code) 
- [ ] XtendWebSetup Project location configuration more flexible
- [ ] remove ExamplesLibrary, make file save optional so that demo.examples never get overridden
- [ ] work without hard-coded HelloWorld.xtend

- [ ] separate project xtend.web.generator: Set up more configurable allow another project to use this without XtendServiceDispatcher and code generation shown in UI

- [ ] multi user

- [ ] security

- [ ] auto format



- [ ] generalize ExamplesLibrary - make it a def init() of Project (for MCS it will just put a build.gradle)
 
- [ ] dirty indicator?

- [ ] multi project, and add all files from ExamplesLibrary

- [ ] README.md instructions how to get it to build on CLI

- [ ] XtendServiceDispatcher getJava2XtendService hasTextInput ?
