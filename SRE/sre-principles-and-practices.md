# 📹 SRE Principles and Practices for Automated and Resilient Operations

SRE can be adopted by implementing **principles and practices** that support scalable and reliable services.

Successful operation of a service involves various activities such as:
- Developing monitoring systems
- Planning capacity
- Responding to incidents
- Addressing root causes of failures

Site Reliability Engineering is based on:
- **7 Principles**
- **18 Practices** that elaborate on those principles

![sre-principles-and-practices](https://github.com/srirymec/devops-sre-learning/blob/main/SRE/images/sre-principles-practices.jpg)

---

## 🧭 7 Principles of SRE

### 1. 🎯 Define the Service Level

- Business services and product teams use:
  - **SLIs** (Service Level Indicators)
  - **SLOs** (Service Level Objectives)
  - **SLAs** (Service Level Agreements)

- These help:
  - Determine the desired level of reliability
  - Ensure **customer satisfaction** is met

- **SLI, SLO, SLA, and Error Budget** are interconnected:
  - **SLO/SLA thresholds** indicate when the customer is happy or unhappy
  - Failing to meet them may lead to **service reliability issues** and **penalties**

![sre-service-levels](https://github.com/srirymec/devops-sre-learning/blob/main/SRE/images/sre-service-levels.jpg)

---

### 2. ⚖️ Embrace Risk

- The goal of SRE is **not** 100% reliability.
- Instead, it **embraces the fact** that systems will fail.
- The focus is on **managing** and **balancing risk**.

- Example:
  - A target of **99.99% availability** is acceptable.
  - Balance is needed between:
    - **Risk of unavailability**
    - **Rapid innovation**
    - **Efficient operations**
  - The aim is to **optimize user happiness** overall.

---

### 3. 🔁 Eliminate Toil

- **Toil** is:
  - Manual
  - Repetitive
  - Automatable
  - Tactical
  - Without enduring value
  - Scales linearly with service size

- Toil should be **identified and reduced**.

- Benefits of toil reduction:
  - Frees up time for **innovation**
  - Leads to **more reliable and automated** service delivery

- Workload management aligned with **toil reduction** ensures progress over time.

---

### 4. 📊 Monitoring

- Traditional monitoring focuses on:
  - Technical metrics: servers, resources, uptime, tickets
  - Mostly **inside the datacenter**

- However, SRE emphasizes:
  - Measuring **end-user experience**
  - Understanding how services behave **at the customer end**

> 💡 Use questions that guide the design of **customer-centric monitoring** systems.

---

### 5. 🤖 Automation

- **Automation** plays a key role in reducing toil:
  - Replaces **manual tasks** with **automated workflows**
  - Ensures **timely deployment** within the **error budget**

- Benefits of automation:
  - Faster responses
  - More efficient workflows
  - Easier, reliable releases

- SREs use automation tools for:
  - **Repetitive operations**
  - **Release processes**

> 📌 Take a look at the list of benefits achievable through automation.

---

### 6. 🚀 Reliable Releases

- Reliable services need **reliable release processes**.
- **Release engineering** helps achieve this.

- Techniques used:
  - Interdependent service isolation
  - Red/green and A/B deployment strategies
  - Real-time **automated remediation**

- Use **experimentation** in production:
  - Launch changes in production environments
  - Use **A/B testing**
  - Automate rollback when issues are detected

---

### 7. 🔍 Simplicity

- **Simplicity** is critical to:
  - Eliminate **unnecessary complexity**
  - Build **stable and reliable** software systems

- SREs aim to:
  - Keep software design **simple**
  - Maintain **agility** and **stability** in balance



