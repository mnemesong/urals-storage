package urals.storage;

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