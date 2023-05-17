pragma solidity ^0.8.0;

contract ArrayExample {
    uint[] public numbers;

    function addNumber(uint newNumber) public {
        numbers.push(newNumber);
    }

    function getSum() public view returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
}
