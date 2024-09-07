# Random Number Generator in Fortran

## Description
This repository contains an implementation of a random number generator in Fortran. The generator uses an XOR-Shift algorithm to produce high-quality random numbers with fast generation speed. It includes a set of tests to evaluate the quality of the generator, including correlation assessment and other statistical tests.

## Content

- generator.f95: Source code of the random number generator in Fortran.
- tests.f95: Source code for quality tests of the generator.
- seeds.dat: Seed file used by the generator.
- README.md: This file.

## Installation and Usage

1. Clone the Repository:
```bash
git clone https://github.com/your-username/random-number-generator-fortran.git
cd random-number-generator-fortran
```

2. Compile the Code:

Ensure you have a Fortran compiler (like gfortran) installed. Compile the code using:
```bash
gfortran -o generator generator.f90
gfortran -o tests tests.f90
```
3. Run the Generator and Tests:

To run the random number generator:
```bash
./generator
```
To run the tests
```bash
./tests
```

## Generator Documentation
The generator is based on an XOR-Shift algorithm and has the following features:

- Precision Type: Double precision (real*8).
- Seeds: Uses a seed file (seeds.dat) for initialization.

## Generator Code

```bash
integer :: ix(0:255)
real*8 :: rr250 = dfloat(1)/(dfloat(2147483647)+dfloat(1))

k0 = 0
!----
open(2, file='seeds.dat')
read (2, *)
do i = 0, 255
    read (2, *) ix(i)
end do
close (2)

k0 = and((k0 + 1), 255)
ix(k0) = xor(ix(and(k0 - 103, 255)), ix(and(k0 - 250, 255)))
rand1 = rr250 * ix(k0)
```

## Tests Performed
- Correlation Test: Evaluates the correlation between consecutive random numbers.
- Distribution Test: Checks if the generated numbers are uniformly distributed.

## Results
- The correlation between consecutive numbers is close to 0, indicating good independence.
- Additional tests were conducted to ensure the quality of the generator.

## Contributions

If you wish to contribute to this project, please follow these steps:

1. **Fork** the repository.
2. **Create** a new branch (git checkout -b feature/new-feature).
3. **Make** your changes and **commit** (git commit -am 'Add new feature').
4. **Push** to your branch (git push origin feature/new-feature).
5. **Create** a **pull request**.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.



