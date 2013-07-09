        @Nightly @Slow
Feature: Adding with tables
        
    Scenario: Add two numbers correctly
        Given the input:
        |left value|right value|
        |2         |2          |
        |3         |3          |
        |4         |4          |
        |5         |5          |       
        When the calculator is run for several values
        Then the output should be:
        |answer|
        |4     |
        |6     |
        |8     |
        |10    |