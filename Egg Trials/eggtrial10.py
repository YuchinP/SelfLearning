## by 10s
attempts = 0
for n in range(1,101):
    total = 0
    x = 0
    x2 = 0
    while x <= 100:
        x = x + 10
        print(total)
        total = total + 1
        if x == n:
            print (total)
            attempts = attempts + total
            break
        elif x > n:
            print(total)
            x2 = x - 10
            while x2 < n:
                x2 = x2 + 1
                total = total + 1
                print(total)
            attempts = attempts + total
            break
        else:
            continue
        
    print(attempts)
    print(attempts/100)


## 1000 total guesses
## 10.0 Average trials

