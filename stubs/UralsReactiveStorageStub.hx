package;

import UralsStorageTypes;

using Lambda;

class UralsReactiveStorageStub extends UralsStaticReactiveStorage<String, Int>
{
    private function setId(data: Array<String>): Array<UralsStored<String, Int>>
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