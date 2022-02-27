# rounding
Impress your friends by exaggarating using rounding. Inspired by https://xkcd.com/2585/ and based on GNU Units.

## Requirements
Be sure to have `bash`, `units` and `awk` installed.

## Usage
Run `./rounding.sh` in a terminal. Enter the value to start with and a target value. Then the start value will be converted to different units and rounded unitl the target value is reached or exceeded.

## Examples
```
> ./rounding.sh 
You have: 1 day
You want: 1 year
1 day = 2 uranusday = 2 neptuneday = 2 d = 3 neptuneday = 4 uranusday = 3 marsday = 5 uranusday = 1 plutoday = 1 sennight = 7 marsday = 1 fortnight = 1 anomalisticmonth = 1 mo = 1 mercuryday = 1 mercuryyear = 3 mo = 2 mercuryday = 1 venusyear = 1 leapyear > 1 year (rounded)
```

```
> ./rounding.sh
You have: 1 EUR
You want: 1000 EUR
1 EUR = 1 CYP = 1 KWD = 1 fin = 1 fiver = 1 sawbuck = 1 tenner = 1 XAG = 1 brpony = 1 dollargold = 1 olddollargold = 2 dollargold = 22 fin = 5 XAG = 4 brpony = 6 XAG = 2 olddollargold = 8 XAG = 4 dollargold = 22 sawbuck = 7 brpony = 1 poundgold = 1 monkey = 1 XPT = 1 XAU > 1000 EUR (rounded)
```

## Problems
- This program is slow, especially for dimensions for which `units` stores a lot of different units. This is because it is written in bash and it calls `units` a lot.
- The simple algorithm does not backtrack. When a loop of length one is detected, the program will simply exit, even if it is still possible to reach the target value. This means that the conversion in the XKCD comic cannot be recreated:
```
> ./rounding.sh
You have: 17 mile/hour
You want: 45 mile/hour
17 mile/hour = 8 VELOCITY = 5 Vl = 9 VELOCITY = 30 fps = 18 admiraltyknot = 21 mph = 6 Vl = 34 fps = 12875226000 ipy = 12875226000 ipy
Loop detected, exiting

```
- Loops of length higher than one are not detected, the program will just run in an infinite loop. Example:
```
> ./rounding.sh
You have: 1 sec
You want: 1 year
1 sec = 6 Tim = 7 timeatom = 112 jiffies = 46302338000000000 atomictime = 112 jiffies = 46302338000000000 atomictime = 112 jiffies (...)
```
- SI prefixes are not taken into account for intermediate units. You can use them for start and target values.
- Sometimes weird names for common units are used. For example the unit 'VELOCITY' instead of 'm/s' above.