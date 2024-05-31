```mermaid
%%This is a single class, Treat the class as methods
classDiagram
CombinedAmount --|> AddByThree
CombinedAmount --|> IsLeapYear
IsLeapYear --|> DiscountBy20 :Yes
IsLeapYear --|> DiscountBy10 :No

class CombinedAmount {
  <<Method>>
  +InitialAmount
  +Date
  Returns CombinedAmount
}

class AddByThree {
  <<Method>>
  +Amount
  Returns Amount
}

class DiscountBy20 {
  <<Method>>
  +Amount
  Returns DiscountedAmount
}

class DiscountBy10 {
  <<Method>>
  +Amount
  Returns DiscountedAmount
}

class IsLeapYear {
  <<Method>>
  +Date
  Returns Boolean
}
```