# 🐚 What is a Shell?

- A **Shell** is a program that acts as an interface between the user and the operating system.
- It interprets the commands entered by the user and executes them.

### 🧩 Types of Shells

| Shell | Description                       |
|-------|-----------------------------------|
| sh    | Bourne Shell (original UNIX shell) |
| bash  | Bourne Again Shell (most common)  |
| zsh   | Z Shell (feature-rich)            |
| ksh   | Korn Shell                        |
| csh   | C Shell (C-like syntax)           |

---

# 📜 What is Shell Scripting?

- Shell scripting is the process of writing a sequence of commands in a file to automate tasks.
- These files are called shell scripts, typically saved with `.sh` extension.

---

# 🛠 Getting Started with a Shell Script

### 🏁 Writing Your First Script

```bash
#!/bin/bash
echo "Welcome to Shell Scripting!"
```
The line #!/bin/bash is called a Shebang. It tells the system to use the bash interpreter.

Save the file as hello.sh.

# 🔑 Make Script Executable

```bash
chmod +x hello.sh
./hello.sh
```

# 📦 Variables in Shell

## 🔸 Declaring and Using Variables

```bash
name="Ravi"
age=25
```
echo "Name: $name"
echo "Age: $age"

> ⚠️ **Note:** No spaces around `=` when assigning variables.

## 🔸 Variable Types

| Type       | Example             |
|------------|---------------------|
| String     | `name="Ravi"`       |
| Integer    | `num=5`             |
| Read-only  | `readonly pi=3.14`  |
| Unset      | `unset name`        |

# ⌨ User Input

```bash
read -p "Enter your name: " username
echo "Hello, $username!"
```
- read is used to get input from the user.

- `-p` allows prompting the user inline.

# 🔢  Arithmetic Operations

## ✅ Basic Arithmetic

```bash
a=10
b=5

echo "Sum = $((a + b))"
echo "Product = $((a * b))"
```

## 🔸 With `expr`

```bash
expr $a + $b
```

## 🔹 Floating-point Arithmetic (with `bc`)

```bash
echo "scale=2; 5 / 3" | bc
```



