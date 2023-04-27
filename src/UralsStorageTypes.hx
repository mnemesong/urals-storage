package;

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