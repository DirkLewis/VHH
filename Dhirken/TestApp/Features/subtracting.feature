@myTag
Feature: Subtracting

  Scenario: Subtract two numbers correctly
    Given the input 2 - 2
    When the calculator is run
    Then the output should be 0
    
