import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.0
import QtQuick.Controls 2.0

Window {
    width: 940
    height: 940
    visible: true
    title: qsTr("Super Shapes")
    color: "black"

    function superShape(angle) {
        var n1 = sliderN1.value
        var n2 = sliderN2.value
        var n3 = sliderN3.value
        var m = sliderM.value
        var a = 1
        var b = 1

        var part1 = ( 1 / a ) * Math.cos( m * angle / 4 )
        part1 = Math.abs(part1)
        part1 = Math.pow(part1, n2)

        var part2 = ( 1 / b ) * Math.sin( m * angle / 4 )
        part2 = Math.abs(part2)
        part2 = Math.pow(part2, n3)

        var r = Math.pow( part1 + part2, 1 / n1 )

        if ( r == 0 ) return 0;

        return 1 / r;
    }

    Column {
        spacing: 10

        Label {
            id: labelN1
            text: "N1 : " + sliderN1.value
            color: "steelblue"
            font.pixelSize: 20
        }

        Slider {
            id: sliderN1
            from: 0
            to: 10
            value: 1
            stepSize: 0.01

            onValueChanged: {
                canvas.requestPaint()
            }
        }

        Label {
            id: labelN2
            text: "N2 : " + sliderN2.value
            color: "steelblue"
            font.pixelSize: 20
        }

        Slider {
            id: sliderN2
            from: 0
            to: 10
            value: 1
            stepSize: 0.01

            onValueChanged: {
                canvas.requestPaint()
            }
        }

        Label {
            id: labelN3
            text: "N3 : " + sliderN3.value
            color: "steelblue"
            font.pixelSize: 20
        }

        Slider {
            id: sliderN3
            from: 0
            to: 10
            value: 1
            stepSize: 0.01

            onValueChanged: {
                canvas.requestPaint()
            }
        }

        Label {
            id: labelM
            text: "M : " + sliderM.value
            color: "steelblue"
            font.pixelSize: 20
        }

        Slider {
            id: sliderM
            from: 0
            to: 20
            value: 0
            stepSize: 1

            onValueChanged: {
                canvas.requestPaint()
            }
        }

    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = canvas.getContext("2d")
            ctx.reset()

            ctx.fillStyle = "white"
            ctx.strokeStyle = "white"
            ctx.lineWidth = 3

            ctx.beginPath()

            var shapeRadius = 100;
            const center = width / 2
            var step = 2 * Math.PI / 500;

            for ( var angle = 0; angle < 12 * Math.PI; angle += step ) {
                var r = superShape(angle)
                var x = center + ( shapeRadius * r * Math.cos(angle) )
                var y = center + ( shapeRadius * r * Math.sin(angle) )
                ctx.lineTo(x, y)
            }

            ctx.closePath()

            ctx.fill()
            ctx.stroke()
        }
    }

    Component.onCompleted: {
        canvas.requestPaint()
    }
}
