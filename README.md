# Exceftion

_Exceftion_ provides the `Exception` class for Swift, which has `callStack` and `cause` like `Exception` in Java.

```swift
class FooException: Exception {}
func foo() throws {
    throw FooException(message: "foo")
}
func bar() throws {
    try foo()
}
func baz() throws {
    try bar()
}

do {
    try baz()
} catch let error {
    print(error)
}
```

```
FooException: foo
    0   Exceftion                           0x00000001001a00de _TFC9Exceftion9ExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 158
    1   ExceftionTests                      0x000000010018762e _TFC14ExceftionTests12FooExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 110
    2   ExceftionTests                      0x00000001001876c3 _TFC14ExceftionTests12FooExceptionCfT7messageSS5causeGSqPs5Error___S0_ + 83
    3   ExceftionTests                      0x000000010018774d _TF14ExceftionTests3fooFzT_T_ + 125
    4   ExceftionTests                      0x000000010018778c _TF14ExceftionTests3barFzT_T_ + 28
    5   ExceftionTests                      0x0000000100181bbc _TF14ExceftionTests3bazFzT_T_ + 28
    ...
```

```swift
class QuxException: Exception {}
func qux() throws {
    do {
        try baz()
    } catch let error {
        throw QuxException(message: "qux", cause: error)
    }
}

do {
    try qux()
} catch let error {
    print(error)
}
```

```
QuxException: qux
    0   Exceftion                           0x00000001001a00de _TFC9Exceftion9ExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 158
    1   ExceftionTests                      0x00000001001878be _TFC14ExceftionTests12QuxExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 110
    2   ExceftionTests                      0x0000000100187953 _TFC14ExceftionTests12QuxExceptionCfT7messageSS5causeGSqPs5Error___S0_ + 83
    3   ExceftionTests                      0x0000000100181ca1 _TF14ExceftionTests3quxFzT_T_ + 177
    ...
Caused by FooException: foo
    0   Exceftion                           0x00000001001a00de _TFC9Exceftion9ExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 158
    1   ExceftionTests                      0x000000010018762e _TFC14ExceftionTests12FooExceptioncfT7messageSS5causeGSqPs5Error___S0_ + 110
    2   ExceftionTests                      0x00000001001876c3 _TFC14ExceftionTests12FooExceptionCfT7messageSS5causeGSqPs5Error___S0_ + 83
    3   ExceftionTests                      0x000000010018774d _TF14ExceftionTests3fooFzT_T_ + 125
    4   ExceftionTests                      0x000000010018778c _TF14ExceftionTests3barFzT_T_ + 28
    5   ExceftionTests                      0x0000000100181bbc _TF14ExceftionTests3bazFzT_T_ + 28
    6   ExceftionTests                      0x0000000100181c0c _TF14ExceftionTests3quxFzT_T_ + 28
    ...
```

## License

MIT
