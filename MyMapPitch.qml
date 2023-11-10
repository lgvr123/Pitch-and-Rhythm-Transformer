import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{  
    id:root 
    //property var itemsArr: noteMap
    //property var listCount: mapList.count
    property var allOct: allOctaves.checked
    property var noteIn: noteBoxFrom.currentText;
    property var accIn: accidentalBoxFrom.currentText;
    property var octIn: octaveBoxFrom.value
    property var enharm: enharmonic.checked
    property var noteOut: noteBoxTo.currentText;
    property var accOut:accidentalBoxTo.currentText;
    property var octOut: octaveBoxTo.value 
    property var down: downBtn.checked                         
    property var up:  upBtn.checked                      
    property var filter: mapPitchSwitch.position==1 //filter checked

    anchors{
        left: parent.left
        top: parent.top
        verticalCenter: invertByPitch.verticalCenter
        leftMargin: 20
        topMargin: 50
    }   
    ColumnLayout{
        id: pitchMapBoxes    
        spacing: 10    
        RowLayout{                         
            Label{ 
                anchors.verticalCenter: parent.verticalCenter
                id: mapPitchOption              
                text: "Map Pitch"
                font.family: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white"
            }
                    
            Switch { 
                id: mapPitchSwitch
                anchors.verticalCenter: diatonic.verticalCenter 
                hoverEnabled: true
                opacity: hovered ? 0.8:1 
                //checked: true
                indicator: Rectangle {
                    implicitWidth: 40
                    implicitHeight: 16
                    x: mapPitchSwitch.width - width - mapPitchSwitch.rightPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    color: (mscoreMajorVersion >= 4)? ui.theme.textFieldColor :"#242427"//"#565656" : "#565656"
                    border.color: (mscoreMajorVersion >= 4)? ui.theme.strokeColor : "#2d2d30"

                    Rectangle {
                        x: mapPitchSwitch.checked ? parent.width - width : 0
                        width: 16
                        height: 16
                        radius: 13
                        border.color: (mscoreMajorVersion >= 4)? ui.theme.strokeColor:"#2d2d30"
                        color: (mscoreMajorVersion >= 4)? ui.theme.accentColor : "#277eb9"//"#40acff"//"#265f97"
                    }
                }
            }
        
            Label{ 
                anchors.verticalCenter: parent.verticalCenter
                id: filterOptions 
                text: "Filter/Select Pitch"
                font.family: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white"
            }  
        }
        // Row{
        // height: 30
        // spacing: 2
        //     Button{   
        //         id: mapPitchOption              
        //         text: "Map Pitch:"
        //         checkable: true
        //         checked: !filterOptions.checked
        //         hoverEnabled: true
        //         highlighted: hovered
        //         implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
                
        //     }   
        //     Button{
        //         id: filterOptions 
        //         text: "Filter/Select Pitch"
        //         checkable: true
        //         checked: !mapPitchOption.checked
        //         hoverEnabled: true
        //         highlighted: hovered
        //         implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
            
        //     }
        // }
               
        Row{ 
            id: mapFromRow  
            spacing: 2
            height: 25
            MyComboBox {               
                id: noteBoxFrom                            
                currentIndex: 0                                  
                model: ListModel {
                    id: noteList                        
                    ListElement { text: "C" }
                    ListElement { text: "D" }
                    ListElement { text: "E" }
                    ListElement { text: "F" }
                    ListElement { text: "G" }
                    ListElement { text: "A" }
                    ListElement { text: "B" }                    
                }                              
            }
        
            MyComboBox {               
                id: accidentalBoxFrom                            
                currentIndex: 1                                    
                model: ListModel {                    
                    ListElement { text: "♭" }
                    ListElement { text: "♮" }
                    ListElement { text: "♯" }                                                
                }                            
            }

            SpinBox {
                id: octaveBoxFrom
                enabled: !allOctaves.checked
                width: (mscoreMajorVersion >= 4)?50:undefined
                
                from: 0
                value: 4
                to: 9
                stepSize: 1
                hoverEnabled: true
                opacity: hovered ? 0.8:1 
                ToolTip.visible: hovered
                ToolTip.delay: 500                            
                ToolTip.text: qsTr("8va")
                
                ToolTip.timeout: 1000   
                font.pointSize: 10 
                font.family: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                
                // background: Rectangle {
                //     color:(mscoreMajorVersion >= 4)? ui.theme.textFieldColor : "#242427"
                //     border.color: (mscoreMajorVersion >= 4)? ui.theme.strokeColor : "grey"
                //     radius: 4                           
                // }                                 
            }  
            Button{
                id: allOctaves
                text: "All Octaves"
                checkable: true
                hoverEnabled: true
                highlighted: hovered
                implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
                height: parent.height
                contentItem: Text { 
                    text: allOctaves.text                                     
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter                      
                    elide: Text.ElideRight                                  
                    font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                    color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
                }
                background: Rectangle {                       
                    anchors.fill: parent
                    opacity: allOctaves.hovered ?  (allOctaves.down ? 1 : 0.5) : 0.75 
                    radius:4                    
                    color:{
                        if(mscoreMajorVersion >= 4){
                            if(allOctaves.checked){ ui.theme.accentColor}
                            else{ ui.theme.buttonColor}
                        }
                        else{
                            if(allOctaves.checked){"#277eb9"}
                            else {"#646464"}
                        }
                    }
                }   
                
            }
            Button{
                id: enharmonic                
                text: "Incl. enharmonic notes"
                checkable: true
                hoverEnabled: true
                highlighted: hovered
                implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
                height: parent.height
                contentItem: Text {
                    text: enharmonic.text                                      
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter                       
                    elide: Text.ElideRight                                  
                    font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                    color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
                }
                background: Rectangle {                       
                    anchors.fill: parent
                    opacity: enharmonic.hovered ?  (enharmonic.down ? 1 : 0.5) : 0.75 
                    radius:4                    
                    color:{
                        if(mscoreMajorVersion >= 4){
                            if(enharmonic.checked){ ui.theme.accentColor}
                            else{ ui.theme.buttonColor}
                        }
                        else{
                            if(enharmonic.checked){"#277eb9"}
                            else {"#646464"}
                        }
                    }
                }   
            
            } 
            
        }//Row
            
    }//COlumn
             
    ColumnLayout{
        id: pitchMapBoxes2
        visible: mapPitchSwitch.position==0 //!filterOptions.checked
        spacing: 10
        anchors{
            top: pitchMapBoxes.bottom
            left: pitchMapBoxes.left
            topMargin:10
        }
        
        Label{              
            text: "To:"
            font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
            color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white"
        }
            
        Row{
        spacing: 2
        
            MyComboBox {               
                id: noteBoxTo                            
                currentIndex: 0                                  
                model: ListModel {
                    id: noteListFrom                        
                    ListElement { text: "C" }
                    ListElement { text: "D" }
                    ListElement { text: "E" }
                    ListElement { text: "F" }
                    ListElement { text: "G" }
                    ListElement { text: "A" }
                    ListElement { text: "B" }                    
                }                              
            }
        
            MyComboBox {               
                id: accidentalBoxTo
                currentIndex: 1                                    
                model: ListModel {                    
                    ListElement { text: "♭" }
                    ListElement { text: "♮" }
                    ListElement { text: "♯" }                                                
                }                            
            }

            SpinBox {
                id: octaveBoxTo
                enabled:  !upBtn.checked && !downBtn.checked
                width: (mscoreMajorVersion >= 4)?50:undefined
                
                from: 0
                value: 4
                to: 9
                stepSize: 1
                hoverEnabled: true
                opacity: hovered ? 0.8:1 
                ToolTip.visible: hovered
                ToolTip.delay: 500                            
                ToolTip.text: qsTr("8va")
                
                ToolTip.timeout: 1000   
                font.pointSize: 10 
                font.family: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
            } 
            
            Button{
                id: upBtn
                onClicked: downBtn.checked=false
                text: "Up"
                checkable: true
                hoverEnabled: true
                highlighted: hovered
                implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
                height: parent.height
                contentItem: Text { 
                    text: upBtn.text        
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter                     
                    elide: Text.ElideRight                                  
                    font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                    color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
                }
                background: Rectangle {                       
                    anchors.fill: parent
                    opacity: upBtn.hovered ?  (upBtn.down ? 1 : 0.5) : 0.75  
                    radius:4                    
                    color:{
                        if(mscoreMajorVersion >= 4){
                            if(upBtn.checked){ ui.theme.accentColor}
                            else{ ui.theme.buttonColor}
                        }
                        else{
                            if(upBtn.checked){"#277eb9"}
                            else {"#646464"}
                        }
                    }
                }   
            }
            Button{
                id: downBtn
                implicitWidth: contentItem.implicitWidth+ leftPadding + rightPadding
                height: parent.height
                checkable: true
                onClicked: upBtn.checked=false
                hoverEnabled: true
                highlighted: hovered
                text: "Down"
            
                contentItem: Text {  
                    text: downBtn.text 
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter                                         
                    elide: Text.ElideRight                                  
                    font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                    color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
                }
                background: Rectangle { 
                                          
                    anchors.fill: parent
                    opacity: downBtn.hovered ?  (downBtn.down ? 1 : 0.5) : 0.75  
                    radius:4                    
                    color:{
                        if(mscoreMajorVersion >= 4){
                            if(downBtn.checked){ ui.theme.accentColor}
                            else{ ui.theme.buttonColor}
                        }
                        else{
                            if(downBtn.checked){"#277eb9"}
                            else {"#646464"}
                        }
                    }
                } 
            }  
                    
        }//row 
    }//column 
    /*
    Row{
        id:addRemBtn
        anchors{
            top: pitchMapBoxes2.bottom
            right: pitchMapBoxes2.right
            topMargin: 10
        }
        spacing:5
        anchors{
            topMargin:20
            top:notesBoxTo.bottom
            right: parent.right
        }
        Button{
            id: addBtn
            width: 50               
                                
            hoverEnabled: true 
            highlighted: hovered  
        
            Text {                                      
                anchors.centerIn: parent                 
                elide: Text.ElideRight 
                text: "Add"               
                font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
            }
            background: Rectangle {                       
                anchors.fill: parent
                color: (mscoreMajorVersion >= 4)? ui.theme.buttonColor : "#646464"
                opacity: addBtn.hovered ?  (addBtn.down ? 0.5 : 0.75) : 1 
                radius:4                    
            }   
            onClicked:{   
                noteMap.append({all: allOctaves.checked? "All" : "",
                                noteIn: noteBoxFrom.currentText,
                                accIn: accidentalBoxFrom.currentText,
                                octIn: allOctaves.checked? " ": String(octaveBoxFrom.value) ,
                                enharm: enharmonic.checked? "and enharmonics": "",
                                noteOut: noteBoxTo.currentText,
                                accOut:accidentalBoxTo.currentText,
                                octOut: downBtn.checked? "Down" : upBtn.checked? "Up" :octaveBoxTo.value.toString()  
                                })
                                console.log(root.noteIn)
                                
                                
                        
            }
        }
        Button{
            id: removeBtn
            width: 80            
            hoverEnabled: true 
            highlighted: hovered  
        
            Text {                                      
                anchors.centerIn: parent                 
                elide: Text.ElideRight 
                text: "Remove"               
                font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white" 
            }
            background: Rectangle {                       
                anchors.fill: parent
                color: (mscoreMajorVersion >= 4)? ui.theme.buttonColor : "#646464"
                opacity: removeBtn.hovered ?  (removeBtn.down ? 0.5 : 0.75) : 1 
                radius:4                    
            }   
            onClicked:{
                console.log("selected", mapList.selectedIdx.length)
                if(mapList.selectedIdx.length==0){ 
                    noteMap.remove(noteMap.count-1,1)
                    console.log("count", noteMap.count-1)
                }
                else{                        
                    mapList.selectedIdx.sort(function(a,b){return b-a})  //descending order                                  
                    console.log(mapList.selectedIdx)
                    for (var i in mapList.selectedIdx){
                            noteMap.remove(mapList.selectedIdx[i],1) 
                            console.log(i)                                   
                    }
                    mapList.selectedIdx=[]
                }
            }
        }
    } //Row     

    
    Rectangle{
        visible: !filterOptions.checked
        height:150
        
        
        anchors{                  
            right: pitchMapBoxes.right
            left: pitchMapBoxes.left
            top: addRemBtn.bottom
            topMargin: 10                                 
        }                                 
                
        color: (mscoreMajorVersion >= 4)? ui.theme.textFieldColor : "light grey"                  
        border.color: (mscoreMajorVersion >= 4)?  ui.theme.strokeColor : "white"                    
        radius: 5

        ListView {
            id: mapList
            property var selectedIdx:[]
            
            anchors.fill: parent
            model: ListModel{
                id:noteMap
            }
            delegate: Button {
                id: entry
                checkable: true                
                width: parent.width
                           
                hoverEnabled: true
                highlighted: hovered
                onClicked: {
                     
                    if (checked){
                        mapList.selectedIdx.push(index)
                        console.log(mapList.selectedIdx)
                        
                    }
                    else{
                        var idxOfselectedIdx = mapList.selectedIdx.indexOf(index);
                        console.log(idxOfselectedIdx) 
                        mapList.selectedIdx.splice(idxOfselectedIdx,1) 
                        console.log(mapList.selectedIdx)
                    }
                }          
                      
                  
                background: Rectangle{                    
                    opacity: entry.hovered? 0.5:1
                    anchors.fill: parent
                    color: {
                        if(mscoreMajorVersion >= 4){
                            if(entry.checked){ ui.theme.accentColor}
                            else{ ui.theme.textFieldColor}
                        }
                        else{
                            if(entry.checked){"light blue"}
                            else {"#646464"}
                        }
                    }
                    radius: 5
                }
                Text{
                    text: all+' '+ noteIn+accIn+' '+octIn+' '+enharm+ ' '+" to: "+noteOut+accOut+' '+octOut
                    font: (mscoreMajorVersion >= 4)? ui.theme.bodyFont.family : "segoe UI" 
                    color: (mscoreMajorVersion >= 4)? ui.theme.fontPrimaryColor : "white"
                    anchors.left: parent.left
                }            
            }      
        }//listview
    }//Rectangle maplist        
    */ 

 }//item                      

 
