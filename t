# Project Financial Report - V1 Documentation

## Purpose

The Project Financial Report provides a project-level financial view by combining the Sales Cycle and Buying Cycle within a selected date range.

The report helps users understand whether each project is profitable from an accrual perspective and whether the project has a positive or negative cash position.

This is version 1 of the report. Stock Entry cost is not included in this version and will be handled in a later phase.

---

## Date Filter Logic

The report uses the selected From Date and To Date to filter source documents based on their financial dates:

| Document | Date Field Used |
|---|---|
| Sales Order | Transaction Date |
| Sales Invoice | Posting Date |
| Customer Payment Entry | Posting Date |
| Purchase Order | Transaction Date |
| Purchase Invoice | Posting Date |
| Supplier Payment Entry | Posting Date |

The report does not use the document creation date.

---

## Sales Cycle Calculations

### Expected Revenue

Expected Revenue represents the total value of Sales Order items linked to the project within the selected date range.

Formula:

Expected Revenue = Sum of Sales Order Item Amount

---

### Actual Revenue

Actual Revenue represents the total value of Sales Invoice items linked to the project within the selected date range.

Formula:

Actual Revenue = Sum of Sales Invoice Item Amount

---

### Collected Amount

Collected Amount represents customer payments allocated to Sales Invoices linked to the project.

If a Sales Invoice contains multiple projects, the payment is distributed proportionally based on each project’s item amount inside the invoice.

Formula:

Project Collected Amount =
Payment Allocated Amount × Project Item Amount / Sales Invoice Net Total

---

### Outstanding Revenue

Outstanding Revenue shows the difference between invoiced revenue and collected amount.

Formula:

Outstanding Revenue = Actual Revenue - Collected Amount

---

### Collection Percent

Collection Percent shows how much of the actual revenue has been collected.

Formula:

Collection Percent = Collected Amount / Actual Revenue × 100

If Actual Revenue is zero, Collection Percent will be shown as 0%.

---

## Buying Cycle Calculations

### Committed Cost

Committed Cost represents the total value of Purchase Order items linked to the project within the selected date range.

Formula:

Committed Cost = Sum of Purchase Order Item Amount

---

### Actual Cost

Actual Cost represents the total value of Purchase Invoice items linked to the project within the selected date range.

Formula:

Actual Cost = Sum of Purchase Invoice Item Amount

Note:
Stock Entry cost is not included in V1.

---

### Paid Cost

Paid Cost represents supplier payments allocated to Purchase Invoices linked to the project.

If a Purchase Invoice contains multiple projects, the payment is distributed proportionally based on each project’s item amount inside the invoice.

Formula:

Project Paid Cost =
Payment Allocated Amount × Project Item Amount / Purchase Invoice Net Total

---

### Unpaid Cost

Unpaid Cost shows the difference between actual purchase cost and paid supplier cost.

Formula:

Unpaid Cost = Actual Cost - Paid Cost

---

## Profitability Calculations

### Accrual Profit

Accrual Profit shows the project profit based on invoices, regardless of whether the money has been collected or paid.

Formula:

Accrual Profit = Actual Revenue - Actual Cost

---

### Gross Profit Percent

Gross Profit Percent shows the accrual profit as a percentage of actual revenue.

Formula:

Gross Profit Percent = Accrual Profit / Actual Revenue × 100

If Actual Revenue is zero, Gross Profit Percent will be shown as 0%.

---

### Cash Position

Cash Position shows the cash difference between customer collections and supplier payments within the selected date range.

Formula:

Cash Position = Collected Amount - Paid Cost

Important:
A project can be profitable from an accrual perspective but still have a negative cash position if the company has not collected money from the customer yet or has already paid suppliers.

---

## Timing Difference Calculations

### Revenue Timing Difference

Revenue Timing Difference explains the difference between customer collections and sales invoices in the selected date range.

Formula:

Revenue Timing Difference = Collected Amount - Actual Revenue

If this value is positive, customer collections are higher than sales invoices in the selected range.

If this value is negative, sales invoices are higher than customer collections in the selected range.

This can happen when a payment is received in the selected date range for an invoice posted in a previous period.

---

### Cost Timing Difference

Cost Timing Difference explains the difference between supplier payments and purchase invoices in the selected date range.

Formula:

Cost Timing Difference = Paid Cost - Actual Cost

If this value is positive, supplier payments are higher than purchase invoices in the selected range.

If this value is negative, purchase invoices are higher than supplier payments in the selected range.

This can happen when a supplier payment is made in the selected date range for a purchase invoice posted in a previous period.

---

### Accrual Vs Cash Difference

Accrual Vs Cash Difference compares accrual profitability with cash position.

Formula:

Accrual Vs Cash Difference = Accrual Profit - Cash Position

This helps explain why the accounting profit and cash result may not match.

---

## Status Definitions

### Profit Status

| Status | Meaning |
|---|---|
| Profitable | Actual Revenue is greater than Actual Cost |
| Loss | Actual Cost is greater than Actual Revenue |
| Break Even | Actual Revenue equals Actual Cost |
| Cost Without Revenue | There is cost but no sales invoice revenue in the selected range |
| No Revenue / No Cost | No revenue and no cost in the selected range |

---

### Cash Status

| Status | Meaning |
|---|---|
| Positive Cash Position | Collected Amount is greater than Paid Cost |
| Negative Cash Position | Paid Cost is greater than Collected Amount |
| Neutral Cash Position | Collected Amount equals Paid Cost |

---

### Collection Status

| Status | Meaning |
|---|---|
| No Invoice | No Sales Invoice revenue in the selected range |
| Unpaid | Sales Invoice exists but no collection was found |
| Partially Collected | Collected Amount is less than Actual Revenue |
| Fully Collected | Collected Amount equals Actual Revenue |
| Over Collected | Collected Amount is greater than Actual Revenue |

---

## Included Documents

The report currently includes:

- Sales Order
- Sales Invoice
- Payment Entry Receive against Sales Invoice
- Purchase Order
- Purchase Invoice
- Payment Entry Pay against Purchase Invoice

---

## Excluded From V1

The following items are not included in this version:

- Stock Entry cost
- Material issue cost
- Internal stock transfer cost
- Manual journal entries not linked to Sales/Purchase invoices
- Cost not linked to Project at item level

These items may be added in future versions.

---

## Important Notes

1. The report is project-based and depends on the Project field being filled at the item row level.

2. If a Sales Invoice or Purchase Invoice contains multiple projects, payment allocation is distributed proportionally based on each project’s item amount.

3. Paid Cost can be higher than Actual Cost within a selected date range. This does not always mean an error. It may happen when supplier payments are made during the selected period for purchase invoices posted in earlier periods.

4. Collected Amount can be higher than Actual Revenue within a selected date range. This may happen when customer payments are received during the selected period for sales invoices posted in earlier periods.

5. Accrual Profit and Cash Position are different views:
   - Accrual Profit = Invoice-based profitability
   - Cash Position = Payment-based cash result
