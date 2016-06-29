# Welcome to the Prescription Organizer Sinatra App!

## Introduction

This app builds organizes prescription schedules for individual users.

* It includes four models (and their corresponding tables) `user`, `prescription_pill`, `pill`, and `prescription`.

* A `pill` has many `prescription_pills` and `prescriptions` through `prescription_pills`.
* A `prescription` has many `prescription_pills` and `pills` through `prescription_pills`
* A  `prescription_pill` belongs_to `Prescription` and `Pill`.


**User**

| **id**             | **username**      | **password_digest ** |
|:------------------:|:-----------------:|:--------------------:|
| 1                  | Mussen            | 33424234jkflsfajfa   |
| 2                  | Henry             | 33424234jkflsfadjfa  |
| 3                  | Lin               | dfsakfsdjfdasggk3434 |


**Prescriptions**

| **id** |  **Name**  | **Exp_date**  | **Instructions** | **user_id**  |
|:------:|:----------:|:-------------:|:----------------:|:------------:|
| 1      | Vyvanse    | 12/02/2016     | Before 10am     | 1            | 
| 2      | Iron       | 11/05/2016     | During meal     | 2            |  
| 3      | Adderrall  | 01/02/2017     | Before breakfast| 3            | 


