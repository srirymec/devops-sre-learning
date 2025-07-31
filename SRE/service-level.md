# 🎓 Bite-Sized Learning: SRE Principle – Service Level

Let's talk about one of the SRE principles: **Service Level**.

---

## 🚀 Understanding SRE in Practice

- The focus of SRE is to create **ultra-scalable and highly reliable software systems** that support business functions.
- SRE balances:
  - **New feature delivery**
  - **System stability**
- The goal is to **optimize customer experience**.

SRE emphasizes **measurement** to improve:
- Security
- Performance
- Maintainability
- Scalability
- Usability

---

## ⚙️ Putting SRE into Action

### Key Focus Areas:
1. **How do we measure success?**
2. **What factors enable reliability?**

---

## 📈 Evolution of Service Level

Service levels evolve based on four areas:
- **Measurement**
- **SRE Practices**
- **Accountability**
- **Culture**

### Traditional Focus:
- Monitoring system health, logs, and events
- Less attention to **user experience**

### With Service Level:
- Focus on enhancing **user journey**
- Enables **proactive reliability culture**
- Aligns **dev and business teams** with shared understanding

Example:
- Traditional: Developers talk in terms like tickets/incidents
- With service levels: Product owners have **transparency** into reliability

---

## 🤝 SLA – Service Level Agreement

- **SLA** defines the level of service delivered by a **supplier to a customer**
- SLAs:
  - Describe **customer satisfaction goals**
  - Include metrics like:
    - Reaction time
    - Resolution time
    - Compliance with deadlines
- Primarily used for:
  - **Enterprise-to-enterprise expectations**
- May include **penalties** if not met

### Expanding Use:
- SLAs are now critical across **modern value chains and partnerships**

---

## 🔗 SLIs, SLOs, SLAs, and Error Budgets

Business and product teams use:
- **SLI** – Service Level Indicator
- **SLO** – Service Level Objective
- **SLA** – Service Level Agreement

These determine:
- The **desired level of reliability**
- Whether **customer satisfaction** is being met

### Visual Concept:
- **SLO/SLA thresholds** indicate when a customer is happy/unhappy
- Missing the threshold affects **reliability**, leading to **penalties**

![sre-service-levels](https://github.com/srirymec/devops-sre-learning/blob/main/SRE/images/sre-service-levels.jpg)

---

## 📏 Defining SLIs and SLOs

### What Are SLIs?

- **SLIs** measure health of user journeys from the **user’s perspective**
- Provide an **approximation of end-user experience**
- Start with SLIs that cover **broad portions**, then narrow down

### SLI Menu:
- A starting point to define SLIs

### SLIs:
- Measure ratio of **good vs valid events**
- Ignore:
  - Load testing
  - Automated scripts
- Measured over **time series** using tools

---

### What Are SLOs?

- **SLO thresholds** are set for each SLI
- These thresholds evolve over time based on:
  - **Service changes**
  - **User expectations**

- Use **historical SLI data** to set initial SLOs
- SLOs should:
  - Be slightly **ambitious**
  - Be **realistic**
  - **Make users happy**

> 🎯 Multiple thresholds may exist for **noisy metrics** (e.g. latency)

---

## 📊 Benefits of Service Levels in SRE

- Guides **development and operations** teams in setting reliability goals
- Promotes **realistic expectations**
- Mitigates belief that **every feature must be 100% reliable**


