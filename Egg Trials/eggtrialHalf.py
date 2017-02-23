## by halving
attempts = 0

for n in range(1,101):
    total = 0
    x = 0
    x2 = 0
    while x <= 100:
        x = x + (100-x)/2
        x = round(x)
        print(total)
        total = total + 1
        if x == n:
            print (total)
            attempts = attempts + total
            break
        elif x > n:
            print(total)
            x2 = x - (100 - x)
            while x2 < n:
                x2 = x2 + 1
                total = total + 1
                print(total)
            attempts = attempts + total
            break
        else:
            if x < 97:
                continue
            elif x >= 97:
                print(total)
                while x < n:
                    x = x + 1
                    total = total + 1
                    print(total)
                attempts = attempts + total
                break
    print(attempts)
    print(attempts/100)

## 1808 total guesses
## 18.08 Average Guesses
