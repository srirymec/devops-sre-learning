# Python Interview Questions

<a name="terraform-advanced"></a>
#### :star: Advanced/Scenario based

<details>
<summary>Reverse a string in Python</summary><br>

- **Using Python slice operator**
  ```
  def reverse_string(s):
    return s[::-1]
  
  print(reverse_string("hello"))  # 'olleh'
  ```
  
- **Using loops**
  ```
    def reverse_string(s):
      result = ''
      for char in s:
        result = char + result
      return result

    print(reverse_string("hello"))  # 'olleh'
  
  ```

- **Using Recursion**
  ```
  def reverse_string(s):
    if len(s) == 0:
        return s
    return reverse_string(s[1:]) + s[0]  # Process the remaining substring first

  print(reverse_string("hello"))  # Output: "olleh"

  ```
</details>
