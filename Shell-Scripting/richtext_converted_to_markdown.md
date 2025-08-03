1\. What is a Shell?

A Shell is a program that acts as an interface between the user and the operating system. It interprets commands entered by the user and executes them.

**Types of Shells:**

*   **sh**: Bourne Shell (original UNIX shell)
    
*   **bash**: Bourne Again Shell (most common)
    
*   **zsh**: Z Shell (feature-rich)
    
*   **ksh**: Korn Shell
    
*   **csh**: C Shell (C-like syntax)
    

2\. What is Shell Scripting?

Shell scripting is the process of writing a sequence of commands in a file to automate tasks. These files are called shell scripts and typically have a

.sh extension.

3\. Getting Started with a Shell Script

**Writing Your First Script:**

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   #!/bin/bash  echo "Welcome to Shell Scripting!"   `

The line

#!/bin/bash is called a Shebang, which tells the system to use the bash interpreter. Save the file as

hello.sh.

**Make Script Executable:**

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   chmod +x hello.sh  ./hello.sh   `

4\. Variables in Shell

**Declaring and Using Variables:**

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   name="Ravi"  age=25  echo "Name: $name"  echo "Age: $age"   `

There should be no spaces around the

\= sign when declaring variables.

**Variable Types:**

*   **String**: name="Ravi"
    
*   **Integer**: num=5
    
*   **Read-only**: readonly pi=3.14
    
*   **Unset**: unset name
    

5\. User Input

The read command is used to get input from the user. The

\-p option allows prompting the user inline.

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   read -p "Enter your name: " username  echo "Hello, $username!"   `

6\. Arithmetic Operations

**Basic Arithmetic:**

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   a=10  b=5  echo "Sum = $((a+b))"  echo "Product = $((a*b))"   `

**With expr:**

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   expr $a + $b   `