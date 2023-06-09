package urals.storage;

import uuid.Uuid;
import urals.storage.StorageTypes;

using Lambda;

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