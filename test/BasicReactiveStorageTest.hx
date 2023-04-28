package;

import urals.storage.IdGenFunctions.genIntId;
import urals.storage.BasicReactiveStorage;
import sneaker.assertion.Asserter.*;

function test1() {
    var output = "";
    var stor = new BasicReactiveStorage(
        genIntId,
        (els) -> {
            output = output + els
            .map(e -> 'sets(id: ${Std.string(e.id)}, val: ${e.val})\n')
            .join("");
        },
        (els) -> {
            output = output + els
            .map(e -> 'gets(id: ${Std.string(e.id)}, val: ${e.val})\n')
            .join("");
        }
    );
    stor.reInit(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");

    stor.reInit(["azaza", "gagaga"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "azaza");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "gagaga");

    assert(output == 
        ( 'sets(id: 1, val: alala)\n' 
        + 'sets(id: 2, val: blablabla)\n'
        + 'sets(id: 3, val: ohoho)\n'
        + 'gets(id: 1, val: alala)\n' 
        + 'gets(id: 2, val: blablabla)\n'
        + 'gets(id: 3, val: ohoho)\n'
        + 'sets(id: 1, val: azaza)\n' 
        + 'sets(id: 2, val: gagaga)\n'
        + 'gets(id: 1, val: azaza)\n' 
        + 'gets(id: 2, val: gagaga)\n'));
}


function main() {
    test1();
}