<!-- TOC -->

- [physicalConstantSI](#physicalconstantsi)
  - [supported constant](#supported-constant)
  - [supported unit](#supported-unit)
- [usage](#usage)
  - [physical constant](#physical-constant)
  - [from syms to float](#from-syms-to-float)
  - [unit system transformation](#unit-system-transformation)

<!-- /TOC -->
## physicalConstantSI
This script defines a class in matlab, which can express physical quantity in S.I., or in m,s,kg,C,K. 

It also restore some basic physical constants, such as $\hbar$,these data come from 
<a href="https://pdg.lbl.gov/2020/reviews/rpp2020-rev-phys-constants.pdf" target="_blank">particle data group</a>

This script can also transform values between S.I. and natural units.
### supported constant
|c|h|hbar|e|
|-|-|-|-|
|speed of light|Planck constant|Planck constant reduced|charge of electron|

|m_p|m_n|m_e
|-|-|-|
|mass of proton|mass of Neutron|mass of electron|

|alpha_e|alpha_s|G_g|
|-|-|-|
fine-structure constant of electromagneism|strong coupling constant|gravational constant|

|k_B|N_A|
|-|-|
Boltzman constant|Avagadro constant

### supported unit
- basic units

|m|s|kg|C|K|
|-|-|-|-|-|
|meter|second|kilogram|Coulomb|Kelvin|

- daily units
  
|J|N|g|cm|
|-|-|-|-|
|$kg*m^2/s^2$|$kg*m/s^2$|$10^{-3}kg$|$10^{-2}$m|

- energy

|eV|MeV|GeV|TeV|PeV|EeV|
|-|-|-|-|-|-|
|$1.602176634*10^{-19}kg*m^2/s^2$|$10^6eV$|$10^9eV$|$10^{12}eV$|$10^{15}eV$|$10^{18}eV$|

- area

|b|Mb|kb|mb|mub|nb|pb|fb|ab|zb|yb|
|-|-|-|-|-|-|-|-|-|-|-|
|$10^{-28}m^2$|$10^6b$|$10^3b$|$10^{-3}b$|$10^{-6}b$|$10^{-9}b$|$10^{-12}b$|$10^{-15}b$|$10^{-18}b$|$10^{-21}b$|$10^{-24}b$|



## usage
This script is a matlab class, so if you want use it,you can download this script and type
```matlab
phy = physicalConstantSI;
```
### physical constant
If you want to use constant store in it, for example $\hbar$,type
```matlab
hbar = phy.hbar;
```
Then you will get a syms varable
```matlab
hbar=1.054571817e-34*kg*m^2/s
```
You can use the constants in it to do calculation, for example, calculate $E=m_ec^2$,type
```matlab
E=phy.m_e*phy.c^2
```
### from syms to float 
Be careful, calculating with the quantities in physicalConstantSI will generate syms variables, if you want get float results, such as ```E=phy.m_e*phy.c^2```
- S.I.
```matlab
E_SI = phy.valueSI(E)
```
- Natural unit
```matlab
[E_Natural,D] = phy.valueNatural(E)
```
Here `D` is the dimension of eV

### unit system transformation
It can transfrom unit system from Natural unit to S.I.
```matlab
E_InSI=phy.Natural2SI(E_inNatural,unit)
```
Here `E_inNatural` is syms variable in Natural unit, `unit` is the unit of the variable, this function support the following units

| energy | momentum | mass | time | length | area |
|---|---|---|---|---|---|
