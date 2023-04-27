# urals-storage


## Description
Abstract storage interface and some classes implements them.

It may be used for incapsulates some complexity mechanics, for example on action 
triggers, web communications and other functions under basic storage interface.


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.


## Example of usage
```haxe
var stor = new UralsSimpleStorage<String>();
stor.addMany(["alala", "blablabla", "ohoho"]);
var readedAll = stor.readAll();
// [{id: 1, val: "alala"}, {id: 2, val: "blablabla"}, {id: 3, val: "ohoho"}]

stor.removeMany([0, 1, 2]); //id: 0 not exist and will be ignored
var readedAll = stor.readAll();
// [{id: 3, val: "ohoho"}]
```


## UralsBasicStorageInterface API
```haxe
/**
    Interface of minimal storage
**/
interface UralsBasicStorageInterface<M, IdType>
{
    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, IdType>>;

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void;
}
```


## UralsStandardStorageInterface API
```haxe
/**
    Interface represents storage
**/
interface UralsStandardStorageInterface<M, IdType> 
    extends UralsBasicStorageInterface<M, IdType>
{
    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>>;

    /**
        Add some data in the end of storage
    **/
    public function addMany(data: Array<M>): Void;

    /**
        Removes many records from storage by ids
    **/
    public function removeMany(
        ids: Array<IdType>
    ): Void;

    /**
        Set and rewrite many records to storage by ids
    **/
    public function setMany(data: Array<UralsStored<M, IdType>>): Void;
}
```


## UralsReactiveStorageInterface API
```haxe
/**
    Reactive storage interface
**/
interface UralsReactiveStorageInterface 
{
    public function triggerOnChange(): Void;

    public function triggerOnRead(): Void;
}
```


## Classes realizaion
```haxe
class UralsBasicStaticStorage<M, Id> 
    implements UralsBasicStorageInterface<M, Id> {...}

class UralsBasicReactiveStorage<M, Id> 
    implements UralsBasicStorageInterface<M, Id>
    implements UralsReactiveStorageInterface {...}

class UralsStandardStaticStorage<M, IdType> 
    implements UralsStandardStorageInterface<M, IdType> {...}

class UralsStandardReactiveStorage<M, IdType> 
    implements UralsStandardStorageInterface<M, IdType> 
    implements UralsReactiveStorageInterface {...}

```


## Types in UralsStorageTypes module
```haxe
//UralsStorageType.hx

/**
    Type represents data contains in storage
**/
typedef UralsStored<M, IdType> = {
    id: IdType,
    val: M
};

/**
    Type represents function triggers on some storage event
**/
typedef UralsStorageTriggerFunc<M, IdType> = 
    (data: Array<UralsStored<M, IdType>>) -> Void;

/**
    Generates Id function type
**/
typedef UralsSetIdFunc<M, Id> = (
    newData: Array<M>, 
    keepedDataIds: Array<Id>
) -> Array<UralsStored<M, Id>>
```

## Id-gen functions for storages
```haxe
//UralsIdGenFunctions.hx

/**
    Function generates Int id and wraps new data into it
**/
function genIntId<M>(
    newData: Array<M>, 
    keepedData: Array<Int>
): Array<UralsStored<M, Int>> {
    var maxId = keepedData.fold((id, maxId: Int) -> maxId > id ? maxId : id, 0);
    return newData.fold((el: M, m: Array<UralsStored<M, Int>>) 
        -> m.concat([{id: m.length + maxId + 1, val: el}]), []);
}

/**
    Function generates Int id and wraps new data into it
**/
function genUuidId<M>(
    newData: Array<M>, 
    keepedData: Array<String>
): Array<UralsStored<M, String>> {
    return newData.fold((el: M, m: Array<UralsStored<M, String>>) 
        -> m.concat([{id: Uuid.v4(), val: el}]), []);
}
```


## Author
Anatoly Starodubtsev
Tostar74@mail.ru