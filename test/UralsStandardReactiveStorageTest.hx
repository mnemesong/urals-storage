package;

import UralsIdGenFunctions.genIntId;
import sneaker.assertion.Asserter.*;

function test1() {
    var output = "";
    var stor = new UralsStandardReactiveStorage(
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
    stor.addMany(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");

    stor.removeMany([0, 1, 2]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 3);
    assert(readedAll[0].val == "ohoho");
    
    assert(output == 
        ( 'sets(id: 1, val: alala)\n' 
        + 'sets(id: 2, val: blablabla)\n'
        + 'sets(id: 3, val: ohoho)\n'
        + 'gets(id: 1, val: alala)\n' 
        + 'gets(id: 2, val: blablabla)\n'
        + 'gets(id: 3, val: ohoho)\n'
        + 'sets(id: 3, val: ohoho)\n'
        + 'gets(id: 3, val: ohoho)\n'));
}


function test2() {
    var output = "";
    var stor = new UralsStandardReactiveStorage(
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
    stor.setMany([{id: 2, val: "blablabla"}, {id: 3, val: "ohoho"}]);
    var readedAll = stor.readMany([3]);
    assert(readedAll[0].id == 3);
    assert(readedAll[0].val == "ohoho");

    stor.setMany([{id: 2, val: "gagaga"}, {id: 1, val: "alala"}]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 2);
    assert(readedAll[0].val == "gagaga");
    assert(readedAll[1].id == 3);
    assert(readedAll[1].val == "ohoho");
    assert(readedAll[2].id == 1);
    assert(readedAll[2].val == "alala");
    assert(output == 
        ( 'sets(id: 2, val: blablabla)\n'
        + 'sets(id: 3, val: ohoho)\n'
        + 'gets(id: 2, val: blablabla)\n'
        + 'gets(id: 3, val: ohoho)\n'
        + 'sets(id: 2, val: gagaga)\n'
        + 'sets(id: 3, val: ohoho)\n'
        + 'sets(id: 1, val: alala)\n'
        + 'gets(id: 2, val: gagaga)\n'
        + 'gets(id: 3, val: ohoho)\n'
        + 'gets(id: 1, val: alala)\n'));
}

function test3() {
    var output = "";
    var stor = new UralsStandardReactiveStorage(
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
    test2();
    test3();
}