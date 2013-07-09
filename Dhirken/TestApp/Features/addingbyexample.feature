        @Nightly @Slow
Feature: Adding
        
    Scenario: Add two numbers correctly
    Given the input <left> + <right>
    When the calculator is run
    Then the output should be <answer> with a result <outcome>
    
    Examples: Success Examples
    |left|right|answer|outcome|
    |2   |2    |4     |pass   |
    |2   |3    |5     |pass   |
    |2   |4    |6     |pass   |
    |2   |5    |7     |pass   |
    
    Examples: Failure Examples
    |left|right|answer|outcome|
    |2   |3    |6     |fail   |
    |2   |4    |7     |fail   |
    |2   |5    |8     |fail   |
    |2   |6    |9     |fail   |