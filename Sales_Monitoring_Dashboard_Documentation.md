# Sales Monitoring Dashboard Documentation

## 1. Purpose

The **Sales Monitoring Dashboard** is used to monitor the financial and operational status of sales-related records in ERPNext.

It brings together information from the following areas:

- Contracts
- Sales Orders
- Sales Invoices
- Payment Entries
- Payment Allocations

The dashboard is designed to help users track project-related sales performance, billing progress, collections, outstanding amounts, overdue invoices, and linked contract information in one place.

---

## 2. Data Source

The dashboard reads data from the cached DocType:

**Sales Monitoring Entry**

This cache table is used instead of reading directly from the original ERPNext documents every time the dashboard opens. This improves performance and keeps the dashboard faster when there are many Sales Orders, Sales Invoices, Contracts, and Payment Entries.

Only records where:

```text
is_active = 1
```

are included in the dashboard.

The dashboard uses the following source types from the cache:

| Source Type | Used For |
|---|---|
| Contract | Linked contract information and contract KPI cards |
| Sales Order | Sales Order KPI cards and Sales Order table |
| Sales Invoice | Sales Invoice KPI cards and Sales Invoice table |
| Payment Allocation | Payment Entry and payment allocation KPI cards and table |

---

## 3. Main Dashboard Filters

The filters at the top of the dashboard control the data loaded from the server.

### 3.1 From Date / To Date

These filters are applied differently depending on the document type:

| Section | Date Field Used |
|---|---|
| Sales Invoice | Posting Date |
| Sales Order | Created Date |
| Payment Allocation | Posting Date |
| Contract | Date filter is not applied |

Contracts are intentionally not filtered by date because a contract may be linked to a project even if its start or end date is outside the selected transaction date range.

### 3.2 Project

The Project filter checks both:

```text
project
linked_projects
```

This allows the dashboard to include records where the project is stored directly in the document header or inside linked project fields.

### 3.3 Project Type

The Project Type filter includes only records matching the selected project type.

### 3.4 Customer

The Customer filter includes only records matching the selected customer.

### 3.5 Document Status

The Document Status filter controls whether the dashboard shows Draft, Submitted, or Cancelled records.

The mapping is:

| ERPNext docstatus | Dashboard Label |
|---:|---|
| 0 | Draft |
| 1 | Submitted |
| 2 | Cancelled |

If no Document Status is selected, the dashboard shows all document statuses.

---

## 4. Table Filters and KPI Recalculation

Each table has its own filters above it. These filters work on the loaded dashboard data.

When a table filter is applied, the related KPI cards are recalculated based on the visible rows only.

For example:

- Filtering the Sales Order table recalculates only the Sales Order KPI cards.
- Filtering the Sales Invoice table recalculates only the Sales Invoice KPI cards.
- Filtering the Payment Entry table recalculates only the Payment Entry KPI cards.
- Filtering the Contract table recalculates only the Contract KPI cards.

This allows the user to analyze subsets of data without reloading the whole dashboard from the server.

---

## 5. Sorting

All dashboard tables support column sorting.

Clicking a column header sorts the table by that column:

- First click: ascending order
- Second click: descending order

Sorting supports:

- Text values
- Numbers
- Currency values
- Dates
- Percentages

---

## 6. Contract Section

### 6.1 Contract KPI Cards

| KPI Card | Calculation |
|---|---|
| Linked Contracts | Count of linked Contract rows |
| Active Contracts | Count where Contract Status = Active |
| Inactive Contracts | Count where Contract Status is not Active |
| Contract Period | Earliest Start Date → Latest End Date |

### 6.2 Contract Status Logic

The dashboard uses:

```text
contract_status
```

If `contract_status` is not available, it uses:

```text
source_status
```

### 6.3 Contract Period

The Contract Period card is calculated as:

```text
Earliest Start Date = MIN(start_date)
Latest End Date = MAX(end_date)
```

The dashboard displays:

```text
Earliest Start Date → Latest End Date
```

### 6.4 Contract Table Filters

The Contract table may include filters such as:

- Document Status
- Contract Status
- Matched By
- Header Project

---

## 7. Sales Order Section

### 7.1 Sales Order KPI Cards

| KPI Card | Calculation |
|---|---|
| Total Orders | Count of Sales Order rows |
| Fully Invoiced Orders | Count where `per_billed >= 99.99` |
| Partially Invoiced Orders | Count where `0 < per_billed < 99.99` |
| Zero Invoiced Orders | Count where `per_billed <= 0` |
| Not Fully Invoiced Orders | Count where `per_billed < 99.99` |
| Fully Invoiced % | Fully Invoiced Orders / Total Orders × 100 |
| SO Grand Total | Sum of `grand_total` |
| Billed Amount | Sum of `billed_amount` |
| Unbilled Amount | Sum of `unbilled_amount` |
| Billed Amount % | Billed Amount / SO Grand Total × 100 |
| SO Net Total | Sum of `net_total` |
| SO Discount | Sum of `discount_amount` |

### 7.2 Sales Order Formulas

#### Fully Invoiced Orders

```text
Fully Invoiced Orders = Count of Sales Orders where per_billed >= 99.99
```

#### Partially Invoiced Orders

```text
Partially Invoiced Orders = Count of Sales Orders where per_billed > 0 and per_billed < 99.99
```

#### Zero Invoiced Orders

```text
Zero Invoiced Orders = Count of Sales Orders where per_billed <= 0
```

#### Not Fully Invoiced Orders

```text
Not Fully Invoiced Orders = Count of Sales Orders where per_billed < 99.99
```

#### Fully Invoiced Percentage

```text
Fully Invoiced % = (Fully Invoiced Orders / Total Orders) × 100
```

#### Billed Amount Percentage

```text
Billed Amount % = (Billed Amount / SO Grand Total) × 100
```

If the total is zero, the percentage is shown as `0%` to avoid division by zero.

### 7.3 Billing Status Logic

The dashboard classifies Sales Orders as:

| Condition | Billing Status |
|---|---|
| `per_billed >= 99.99` | Fully Billed |
| `per_billed > 0 and per_billed < 99.99` | Partly Billed |
| `per_billed <= 0` | Not Billed |

### 7.4 Sales Order Table Filters

The Sales Order table may include filters such as:

- Status
- Billing Status
- Delivery Status
- Document Status
- Project
- Project Type
- Customer

---

## 8. Sales Invoice Section

### 8.1 Sales Invoice KPI Cards

| KPI Card | Calculation |
|---|---|
| Total Invoices | Count of Sales Invoice rows |
| Invoice Total Amount | Sum of `total_amount` |
| Invoice Net Total | Sum of `net_total` |
| Invoice Discount | Sum of `discount_amount` |
| Invoice Grand Total | Sum of `grand_total` |
| Paid Amount | Sum of `paid_amount` |
| Outstanding | Sum of `outstanding_amount` |
| Overdue Amount | Sum of outstanding amount for overdue invoices |
| Collection % | Paid Amount / Invoice Grand Total × 100 |
| Outstanding % | Outstanding Amount / Invoice Grand Total × 100 |

### 8.2 Sales Invoice Formulas

#### Invoice Grand Total

```text
Invoice Grand Total = SUM(grand_total)
```

#### Paid Amount

```text
Paid Amount = SUM(paid_amount)
```

#### Outstanding Amount

```text
Outstanding Amount = SUM(outstanding_amount)
```

#### Overdue Amount

An invoice is considered overdue when:

```text
outstanding_amount > 0
and due_date is before today
```

The formula is:

```text
Overdue Amount = SUM(outstanding_amount where outstanding_amount > 0 and due_date < today)
```

#### Collection Percentage

```text
Collection % = (Paid Amount / Invoice Grand Total) × 100
```

#### Outstanding Percentage

```text
Outstanding % = (Outstanding Amount / Invoice Grand Total) × 100
```

If the Invoice Grand Total is zero, the percentage is shown as `0%`.

### 8.3 Payment Status Logic

The dashboard classifies Sales Invoices as:

| Condition | Payment Status |
|---|---|
| `outstanding_amount <= 0` | Paid |
| `paid_amount > 0 and outstanding_amount > 0` | Partially Paid |
| `paid_amount <= 0 and outstanding_amount > 0` | Unpaid |

### 8.4 Overdue Status Logic

| Condition | Overdue Status |
|---|---|
| `outstanding_amount > 0 and due_date < today` | Overdue |
| Otherwise | Not Overdue |

### 8.5 Overdue Days

```text
Overdue Days = Today - Due Date
```

This is calculated only when the invoice has an outstanding amount and the due date is before today.

### 8.6 Sales Invoice Table Filters

The Sales Invoice table may include filters such as:

- Status
- Payment Status
- Overdue
- Document Status
- Project
- Project Type
- Customer

---

## 9. Payment Entry Section

### 9.1 Payment Entry KPI Cards

| KPI Card | Calculation |
|---|---|
| Payment Entries | Count of distinct Payment Entry documents |
| Payment References | Count of payment allocation rows |
| Allocated Amount | Sum of `allocated_amount` |
| Latest Payment Date | Maximum `posting_date` |
| Payment Coverage % | Allocated Amount / Invoice Grand Total × 100 |
| Payment Difference | Invoice Paid Amount - Payment Entry Allocated Amount |

### 9.2 Payment Entry Formulas

#### Payment Entries

```text
Payment Entries = COUNT(DISTINCT payment_entry)
```

A single Payment Entry may allocate payment to more than one invoice, so the number of Payment Entry documents may be different from the number of payment reference rows.

#### Payment References

```text
Payment References = COUNT(payment allocation rows)
```

#### Allocated Amount

```text
Allocated Amount = SUM(allocated_amount)
```

#### Latest Payment Date

```text
Latest Payment Date = MAX(posting_date)
```

#### Payment Coverage Percentage

```text
Payment Coverage % = (Total Allocated Amount / Invoice Grand Total) × 100
```

#### Payment Difference

```text
Payment Difference = Invoice Paid Amount - Payment Entry Allocated Amount
```

This value helps compare the paid amount recorded on invoices against the allocated payment amount from Payment Entry references.

### 9.3 Payment Entry Table Filters

The Payment Entry table may include filters such as:

- Document Status
- Project
- Payment Type
- Mode of Payment
- Party

---

## 10. Export CSV

The dashboard supports CSV export.

Export behavior:

- Export All CSV exports all dashboard sections.
- Table-level export exports the selected table only.
- If table filters are applied, the export includes only the visible filtered rows.
- The CSV file includes a UTF-8 BOM to support opening Arabic and English text correctly in Excel.

---

## 11. Help Button

The dashboard includes a floating **Help** button at the bottom-left side of the screen.

The Help menu includes:

- Send us an Email
- Create Support Request

The email option opens the user email client with the Process Automation / Business Excellence email address.

The support request option opens a new ERPNext Support Request form.

---

## 12. Important Notes

### 12.1 Draft Records

Draft records are included when the Document Status filter is set to All or Draft.

Draft records may not always have complete financial values because they may not be fully submitted or finalized in ERPNext.

### 12.2 Cancelled Records

Cancelled records are included only when the Document Status filter allows them.

This allows users to review historical or cancelled records when needed.

### 12.3 Contract Date Filter

The date range filter is not applied to Contracts by design.

Contracts are project-related reference records and may remain relevant even if the selected invoice/order/payment date range does not overlap with the contract period.

### 12.4 Payment Allocation Rows

The Payment Entry section is based on payment allocation rows.

This means one Payment Entry can appear more than once if it is allocated to multiple invoices.

---

## 13. Validation Checklist

After any update to the dashboard, use the following checklist:

1. Open the dashboard and click Refresh.
2. Test the main filters:
   - From Date
   - To Date
   - Project
   - Project Type
   - Customer
   - Document Status
3. Test table filters in each section.
4. Confirm KPI cards change when table filters are applied.
5. Confirm currency KPI cards recalculate correctly.
6. Test sorting on different table columns.
7. Export CSV and confirm the exported rows match the visible filtered data.
8. Check browser Console for JavaScript errors.
9. Compare sample totals with ERPNext list/report data for verification.

---

## 14. Summary

The Sales Monitoring Dashboard provides a consolidated view of contracts, orders, invoices, and payment collections.

It supports project-based filtering, document status filtering, table-level analysis, sorting, CSV export, and automatic KPI recalculation based on visible filtered rows.

The dashboard is designed to improve visibility over:

- Contract linkage
- Sales Order billing progress
- Invoice collection status
- Outstanding and overdue amounts
- Payment allocation coverage
- Project-level sales monitoring
