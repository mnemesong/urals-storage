# urals-storage


## Description
Abstract storage interface and some classes implements them.

It may be used for incapsulates some complexity mechanics, for example on action 
triggers, web communications and other functions under basic storage interface.


## Contains
- BasicStorageInterface and StandardStorageInterface (has extra api)
- ReactiveStorageInterface (for storages, should trigger effect on changing)
- Storage classes, implements this interfaces
- id-generation functions for strages initialization


## Usage
As client-side storage and as runtime-only-alive storages on server.
Interfaces in this package may be used for decoupling your program and storage realizations


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.


## Example of usage Static Storage
```haxe
import urals.storage.IdGenFunctions.genUuidId;
import urals.storage.BasicStaticStorage;

var stor = new BasicStaticStorage(
    genUuidId
);
stor.reInit(["alala", "blablabla", "ohoho"]);
var readedAll = stor.readAll();
// {id: 1, val: "alala"}
// {id: 2, val: "blablabla"}
// {id: 3, val: "ohoho"}
```


## BasicStorageInterface API
```haxe
/**
    Interface of minimal storage
**/
interface BasicStorageInterface<M, IdType>
{
    /**
        Read all data from storage
    **/
    public function readAll(): Array<Entity<M, IdType>>;

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void;
}
```


## StandardStorageInterface API
```haxe
/**
    Interface represents storage
**/
interface StandardStorageInterface<M, IdType> 
    extends BasicStorageInterface<M, IdType>
{
    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<Entity<M, IdType>>;

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
    public function setMany(data: Array<Entity<M, IdType>>): Void;
}
```


## ReactiveStorageInterface API
```haxe
/**
    Reactive storage interface
**/
interface ReactiveStorageInterface 
{
    public function triggerOnChange(): Void;

    public function triggerOnRead(): Void;
}
```


## Classes realizaion
```haxe
class BasicStaticStorage<M, Id> 
    implements BasicStorageInterface<M, Id> {...}

class BasicReactiveStorage<M, Id> 
    implements BasicStorageInterface<M, Id>
    implements ReactiveStorageInterface {...}

class StandardStaticStorage<M, IdType> 
    implements StandardStorageInterface<M, IdType> {...}

class StandardReactiveStorage<M, IdType> 
    implements StandardStorageInterface<M, IdType> 
    implements ReactiveStorageInterface {...}

```


## Types in StorageTypes module
```haxe
//StorageType.hx

/**
    Type represents data contains in storage
**/
typedef Entity<M, IdType> = {
    id: IdType,
    val: M
};

/**
    Type represents function triggers on some storage event
**/
typedef StorageTriggerFunc<M, IdType> = 
    (data: Array<Entity<M, IdType>>) -> Void;

/**
    Generates Id function type
**/
typedef SetIdFunc<M, Id> = (
    newData: Array<M>, 
    keepedDataIds: Array<Id>
) -> Array<Entity<M, Id>>
```

## Id-gen functions for storages
```haxe
//IdGenFunctions.hx

/**
    Function generates Int id and wraps new data into it
**/
function genIntId<M>(
    newData: Array<M>, 
    keepedData: Array<Int>
): Array<Entity<M, Int>> {
    var maxId = keepedData.fold((id, maxId: Int) -> maxId > id ? maxId : id, 0);
    return newData.fold((el: M, m: Array<Entity<M, Int>>) 
        -> m.concat([{id: m.length + maxId + 1, val: el}]), []);
}

/**
    Function generates Int id and wraps new data into it
**/
function genUuidId<M>(
    newData: Array<M>, 
    keepedData: Array<String>
): Array<Entity<M, String>> {
    return newData.fold((el: M, m: Array<Entity<M, String>>) 
        -> m.concat([{id: Uuid.v4(), val: el}]), []);
}
```


## Author
Anatoly Starodubtsev
Tostar74@mail.ru