# 💥 Chaos Engineering Principle

---

## ⚙️ Steps to Implement Chaos Engineering

1. **Define Steady State**
   - A measurable output that indicates **normal system behavior**

2. **Form a Hypothesis**
   - Hypothesize that the steady state will continue in **both control and experimental groups**

3. **Introduce Variables**
   - Simulate real-world events like:
     - Server crashes
     - Hard drive failures
     - Network errors
     - Database connectivity issues

4. **Try to Disprove the Hypothesis**
   - Look for a **difference** in steady state between control and experimental groups

---

## 📌 Guiding Principles of Chaos Engineering

1. **Adopt Good Hypotheses**
   - Focus on **measurable outputs**, not internal system attributes
   - Use **short-term measurement** as a proxy for steady state

2. **Use Real-World Events**
   - Prioritize based on:
     - **Potential impact**
     - **Estimated frequency**

3. **Enable Continuous Experimentation**
   - Manual experiments are **not scalable**
   - Prefer **automated and continuous** chaos testing
   - Automation supports **orchestration and analysis**

4. **Use Proper Business Metrics**
   - Metrics should be **system-oriented**, such as:
     - Number of logins per minute during peak
     - Failed logins per minute
     - Declined transactions per second

5. **Run Experiments in Production**
   - Realistic insights come from **live environments**
   - Systems may behave differently based on **traffic and environment**

---

## 🔄 Chaos Engineering and DevOps

Chaos Engineering helps **refine DevOps practices** by categorizing usage/adoption into four groups:

| Category     | Environment       | Disruptions             | Usage Frequency     |
|--------------|-------------------|--------------------------|---------------------|
| **Challengers**  | QA                 | Infra disruptions         | Frequent             |
| **Leaders**      | Production          | Infra + service disruptions | Frequent             |
| **Niche Players**| Development         | Basic disruptions         | Infrequent           |
| **Visionaries**  | Production          | Basic disruptions         | Infrequent           |

---

## 🔓 Open Source Chaos Engineering Scenario

### 1. **Open Chaos Model**
- Thrives at **large scale**
- Adopted under **open source licenses**

### 2. **Chaos APIs and CRDs**
- Tools offer **native config and deployment**
- CRDs serve as APIs for **developers and ops**
- Enable **chaos orchestration**

### 3. **Plugin Infrastructure**
- **Cloud-native** components are **modular**
- Chaos functionality provided via **chaos libraries**

### 4. **Community**
- Success depends on **community adoption**
- Ingredients:
  - APIs
  - Operators
  - Plugin frameworks

Goal: Define a **common way to inject chaos** into systems to support **DevOps adoption**

---

## ✅ Summary

Chaos Engineering offers a **structured, automated** way to test system resilience and improve collaboration between **development** and **operations** teams within the **DevOps framework**.
