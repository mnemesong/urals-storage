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