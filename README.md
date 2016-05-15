# ch.vorburger.xtend.web

https://github.com/eclipse/xtext/pull/1002

## Implementation Notes

Make sure that the base Xtext version in the build.gradle dependencies matches the one in:
   src/main/webapp/index.html: <link rel="stylesheet" type="text/css" href="xtext/2.9.0-SNAPSHOT/xtext-ace.css"/> 
   src/main/webapp/script.js: "xtext/xtext-ace" : "xtext/2.9.2/xtext-ace"
