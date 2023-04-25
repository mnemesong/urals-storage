package;

typedef UralsStored<M, IdType> = {
    id: IdType,
    val: M
};

typedef UralsStorageTriggerFunc<M, IdType> = 
    (data: Array<UralsStored<M, IdType>>) -> Void;