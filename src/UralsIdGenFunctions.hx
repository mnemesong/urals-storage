package;

import UralsStorageTypes;

using Lambda;

function genIntId<M>(
    newData: Array<M>, 
    keepedData: Array<Int>
): Array<UralsStored<M, Int>> {
    var maxId = keepedData.fold((id, maxId: Int) -> maxId > id ? maxId : id, 0);
    return newData.fold((el: M, m: Array<UralsStored<M, Int>>) 
        -> m.concat([{id: m.length + maxId + 1, val: el}]), []);
}