package;

import UralsStorageTypes;

using Lambda;

/**
    class implements simple static storage type with integer ids
**/
class UralsSimpleStorage<M> extends UralsStaticStorage<M, Int>
{
    private function setId(data: Array<M>): Array<UralsStored<M, Int>>
    {
        var maxId = this.els
            .map(el -> el.id)
            .fold((a: Int, max: Int) -> (a > max) ? a : max, 0);
        var result = [];
        for (i in 0...data.length) {
            result.push({id: maxId + 1 + i, val: data[i]});
        }
        return result;
    }
}