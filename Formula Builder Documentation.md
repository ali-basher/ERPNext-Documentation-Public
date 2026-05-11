# Objective Formula Builder – User Guide

This guide explains how to build objective calculation formulas using blocks.  
The Formula Builder works like Lego blocks: the user builds the calculation by combining value blocks, operators, numbers, and functions instead of writing code.

---

## 1. Main Idea

A formula is built from blocks such as:

```text
Sum Achievement Value ÷ Target Value × 100
```

This means:

```text
Progress % = (Total achieved / Target) × 100
```

Another example:

```text
Sum Achievement Value ÷ Sum Total Value × 100
```

This means:

```text
Achievement % = (Completed / Total) × 100
```

---

## 2. Value Blocks

Value blocks are numbers that the system reads or calculates automatically.

### Achievement Count

Counts the number of submitted Objective Achievement records for the selected objective.

Use it when each achievement record represents one completed item.

Example:

```text
Achievement Count ÷ Target Value × 100
```

If the target is 12 and there are 3 submitted achievements:

```text
3 ÷ 12 × 100 = 25%
```

Recommended for simple counting when every achievement equals 1.

---

### Sum Achievement Value

Sums the `Achievement Value` field from all submitted Objective Achievement records for the selected objective.

Example achievements:

```text
Achievement 1 = 1
Achievement 2 = 2
Achievement 3 = 3
```

Result:

```text
Sum Achievement Value = 6
```

Common formula:

```text
Sum Achievement Value ÷ Target Value × 100
```

Use it for numeric objectives such as:

```text
Automate 12 reports
Automate 24 processes
Prepare 2 training sessions
```

This is usually the most useful block for numeric objectives.

---

### Sum Total Value

Sums the `Total Value` field from all submitted Objective Achievement records for the selected objective.

This is used for ratio or percentage objectives.

Example:

```text
Achievement Value = 15
Total Value = 20
```

Formula:

```text
Sum Achievement Value ÷ Sum Total Value × 100
```

Result:

```text
15 ÷ 20 × 100 = 75%
```

Use it for objectives such as:

```text
Resolve 75% of ERP system-related problems
Document 100% of automation tasks
Complete 100% of requests received
```

---

### Target Value

Reads the target value from the current objective row.

Example:

```text
Target Value = 12
```

Common formula:

```text
Sum Achievement Value ÷ Target Value × 100
```

Use it as the denominator for numeric targets.

---

### Current Achieved Value

Reads the current `Achieved Value` stored in the objective row.

This is usually less common than `Sum Achievement Value`, because `Sum Achievement Value` calculates directly from submitted achievements.

Use it only when the achieved value is already calculated or manually maintained.

---

### Current Total Value

Reads the current `Total Value` stored in the objective row.

This is useful when the total value is calculated earlier or filled by an automation.

---

### Achievement %

Reads the current `Achievement %` stored in the objective row.

Example:

```text
Achievement % = 75
```

Possible formula:

```text
Achievement % ÷ Target Value × 100
```

If target is 75:

```text
75 ÷ 75 × 100 = 100%
```

---

### Child Achieved Sum

Sums `Achieved Value` from child objectives linked to this parent objective.

Use it for section, department, or division objectives that collect results from employees or lower units.

Example:

```text
Ali achieved = 6
Ayham achieved = 4
```

Result:

```text
Child Achieved Sum = 10
```

Common formula:

```text
Child Achieved Sum ÷ Target Value × 100
```

Use it for parent numeric objectives such as:

```text
Section target = Automate 24 processes
```

---

### Child Total Sum

Sums `Total Value` from child objectives linked to this parent objective.

Use it for parent ratio objectives.

Example:

```text
Ali solved 15 out of 20
Ayham solved 8 out of 10
```

Result:

```text
Child Achieved Sum = 23
Child Total Sum = 30
```

Formula:

```text
Child Achieved Sum ÷ Child Total Sum × 100
```

Result:

```text
23 ÷ 30 × 100 = 76.67%
```

Use it for parent objectives such as:

```text
Resolve 75% of ERP system-related problems
Document 100% of automation tasks
Complete 100% of received project tasks
```

---

### Child Progress Average

Calculates the average progress percentage of child objectives.

Example:

```text
Ali Progress = 100%
Ayham Progress = 50%
```

Result:

```text
Child Progress Average = 75%
```

Use it only when the parent objective should be the average progress of children.

Do not use it for request-based ratios if employees have different workloads. In that case, use:

```text
Child Achieved Sum ÷ Child Total Sum × 100
```

---

### Child Count

Counts the number of child objectives linked to this parent objective.

Example:

```text
Child Count = 2
```

Possible formula:

```text
Child Achieved Sum ÷ Child Count
```

Use it for special average calculations.

---

## 3. Operator Blocks

Operators are mathematical actions.

### +

Adds two values.

```text
A + B
```

### -

Subtracts one value from another.

```text
A - B
```

### ×

Multiplies values.

```text
A × B
```

### ÷

Divides values.

```text
A ÷ B
```

The system should handle division by zero safely.

### ( and )

Used to control calculation order.

Example:

```text
(Sum Achievement Value ÷ Target Value) × 100
```

---

## 4. Number Blocks

### 100

Used to convert a decimal result into a percentage.

Example:

```text
15 ÷ 20 = 0.75
0.75 × 100 = 75%
```

### 1

Useful in simple formulas.

### 0

Useful for special formulas.

### Custom Number

Allows the user to add a custom number, such as:

```text
75
30
365
12
```

Prefer using `Target Value` instead of hardcoded numbers when possible.

---

## 5. Function Blocks

### Min 100

Limits the result to a maximum of 100.

Example:

```text
Sum Achievement Value = 15
Target Value = 12
```

Without Min 100:

```text
15 ÷ 12 × 100 = 125%
```

With Min 100:

```text
100%
```

Use it when progress should not exceed 100%.

Recommended pattern:

```text
Min 100 ( Sum Achievement Value ÷ Target Value × 100 )
```

---

## 6. Recommended Templates

### Template: Number Target

Formula:

```text
Sum Achievement Value ÷ Target Value × 100
```

Use for numeric goals:

```text
Automate 12 reports
Prepare 2 training sessions
Automate 24 processes
```

---

### Template: Ratio Target

Formula:

```text
Sum Achievement Value ÷ Sum Total Value × 100
```

Use for percentage goals:

```text
Resolve 75% of ERP problems
Document 100% of automation tasks
Complete 100% of consultation requests
```

---

### Template: Child Number

Formula:

```text
Child Achieved Sum ÷ Target Value × 100
```

Use for parent numeric objectives that collect achievements from employees.

Example:

```text
Section target = 24 processes
Ali target = 12
Ayham target = 12
```

---

### Template: Child Ratio

Formula:

```text
Child Achieved Sum ÷ Child Total Sum × 100
```

Use for parent ratio objectives.

Example:

```text
Section target = Resolve 75% of ERP problems
Ali solved 15 / 20
Ayham solved 8 / 10
Section result = 23 / 30 × 100
```

---

## 7. Which Formula Should I Use?

| Objective Type | Recommended Formula |
|---|---|
| Fixed numeric target | Sum Achievement Value ÷ Target Value × 100 |
| Percentage target based on completed / total | Sum Achievement Value ÷ Sum Total Value × 100 |
| Parent numeric target from employees | Child Achieved Sum ÷ Target Value × 100 |
| Parent percentage target from employees | Child Achieved Sum ÷ Child Total Sum × 100 |
| Average progress of child objectives | Child Progress Average |
| Count each submitted achievement as 1 | Achievement Count ÷ Target Value × 100 |

---

## 8. Practical Examples

### Example 1: Automate 12 Reports

Objective:

```text
Automate 12 reports
```

Formula:

```text
Sum Achievement Value ÷ Target Value × 100
```

If achievements total 3:

```text
3 ÷ 12 × 100 = 25%
```

---

### Example 2: Resolve 75% of ERP Problems

Objective:

```text
Resolve 75% of ERP system-related problems
```

Formula:

```text
Sum Achievement Value ÷ Sum Total Value × 100
```

If solved = 15 and total = 20:

```text
15 ÷ 20 × 100 = 75%
```

If target is 75%, this means the target is achieved.

---

### Example 3: Section Automates 24 Processes

Parent objective:

```text
Automate 24 processes
```

Formula:

```text
Child Achieved Sum ÷ Target Value × 100
```

If child objectives achieved:

```text
Ali = 6
Ayham = 4
```

Then:

```text
10 ÷ 24 × 100 = 41.67%
```

---

### Example 4: Section Resolves 75% of Problems

Parent objective:

```text
Resolve 75% of ERP system-related problems
```

Formula:

```text
Child Achieved Sum ÷ Child Total Sum × 100
```

If:

```text
Ali = 15 / 20
Ayham = 8 / 10
```

Then:

```text
23 ÷ 30 × 100 = 76.67%
```

---

## 9. Important Rules

Use numeric formulas when the objective has a fixed number target.

Use ratio formulas when the total is unknown and changes over time.

Use child formulas for parent objectives such as section, department, division, or company goals.

Use average only when the business meaning is truly an average.

Avoid hardcoded numbers when `Target Value` can be used.

Use `Min 100` when progress should not exceed 100%.

---

## 10. Glossary

| Term | Meaning |
|---|---|
| Achievement Value | The completed amount |
| Total Value | The total amount received or available |
| Target Value | The required target |
| Achievement Count | Number of submitted achievement records |
| Child Objective | An objective linked to a parent objective |
| Child Achieved Sum | Sum of achieved values from child objectives |
| Child Total Sum | Sum of total values from child objectives |
| Progress % | The final progress percentage of the objective |
| Achievement % | Completed amount divided by total amount |
