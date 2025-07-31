# 🧰 SRE Principle: Toil

---

## 🔍 What is Toil?

- **Toil** is manual, repetitive, and operational work that is:
  - Ineffective and inefficient
  - Not scalable
  - Should be reduced or eliminated

> Reducing toil fosters **reliable, automated service delivery**.

---

## 📌 Characteristics of Toil

Any work that fits one or more of the following is considered **toil**:

| Characteristic       | Description                                                                                     | Example                                                  |
|----------------------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| **Manual**           | Requires human intervention                                                                    | Running a script manually                                |
| **Repetitive**       | Done repeatedly, even after automation potential is identified                                  | Rollbacks, post-deployment monitoring                    |
| **Automatable**      | Can be done just as well by a machine                                                           | Adding/removing servers, configuration updates           |
| **Tactical**         | Interrupt-driven, reactive work                                                                 | Handling pager alerts                                    |
| **No Enduring Value**| Leaves the system in the same state                                                             | Moving data from PRAM to the cloud                       |
| **Scales Linearly**  | Grows in effort with traffic, service size, or users                                            | Configuring/securing infrastructure                      |

---

## ⚙️ Reducing Toil in Practice

### 📊 Google's Ideal SRE Work Split:
- **50%** on operational tasks (tickets, support)
- **50%** on engineering and development

### 🔁 Strategies to Reduce Toil:

1. **Automation**
   - Treat automation as a **service**
   - Consider design, frequent testing, and post-mortems

2. **Process Change**
   - Identify the root cause before automating
   - Eliminate unnecessary work by adjusting workflows

3. **Engineering**
   - Enhance releases with:
     - Blue/green deployment
     - Canary releases
     - Zero-downtime features

4. **Self-Service**
   - Save hours per sprint by building portals or bots
   - Empower users to resolve simple issues

5. **Culture**
   - Encourage a mindset where toil is:
     - **Ac**
