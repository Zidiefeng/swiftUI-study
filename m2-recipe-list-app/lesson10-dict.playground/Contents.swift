// empty dict
var a:[String:String] = [String:String]()

// infer data type
var b = [String:String]()

// use Any to represent any data type (dangerous)
var c = [String:Any]()

// add key-value pair
a["txp503"] = "KK K" //Optional("KK K")

// retrieve value by key
print(a["txp503"])

// retrieve by key that does not exist
print(a["dsa"]) // nil

// update key-value pair
a["txp503"] = "kkkk kkkk"

// remove key value pair
a["txp503"] = nil

print(a["txp503"])

// deplare dictionary with intial key-value pairs
var d = ["ejf978":"Apple", "asd102":"Leen"]

// Iterating through a dictionary
for pair in d{
    print("key is: " + pair.key)
    print("value is: " + pair.value)
}

// Iterating through a dictionary
for (key, value) in d{
    print("key is: " + key)
    print("value is: " + value)
}

// Iterating through a dictionary
for (key, value) in d{
    print("key is: " + key)
    print("value is: " + value)
}

// tuple
var e:(String, String) = ("sad131", "anee")
print(e.0)
print(e.1)
