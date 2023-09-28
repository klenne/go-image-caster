package main

import (
	"flag"
	"fmt"
	"image"
	"image/jpeg"
	"image/png"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	fmt.Println("Starting")
	inputFile := flag.String("input", "", "Path to the input image")
	outputFile := flag.String("output", "", "Path to the output file")
	outputFormat := flag.String("format", "jpeg", "Output format (jpeg, png)")

	flag.Parse()

	if *inputFile == "" {
		fmt.Println("You need to provide the path to the input image using the -input flag")
		return
	}

	validFormats := map[string]bool{
		"jpeg": true,
		"png":  true,
		"jpg":  true,
	}

	if !validFormats[strings.ToLower(*outputFormat)] {
		fmt.Println("Invalid output format. Choose from: jpeg, png, jpg")
		return
	}

	*inputFile = strings.ReplaceAll(*inputFile, "\\", "/")

	inputImageFile, err := os.Open(*inputFile)
	if err != nil {
		fmt.Println("Error opening the input image:", err)
		return
	}
	defer inputImageFile.Close()

	ext := filepath.Ext(*inputFile)

	ext = ext[1:]
	if *outputFile == "" {
		*outputFile = strings.ReplaceAll(*inputFile, ext, *outputFormat)
	} else {
		*outputFile = strings.ReplaceAll(*outputFile, ext, *outputFormat)
	}

	inputImage, _, err := image.Decode(inputImageFile)
	if err != nil {
		fmt.Println("Error decoding the input image:", err)
		return
	}

	outputImageFile, err := os.Create(*outputFile)
	if err != nil {
		fmt.Println("Error creating the output file:", err)
		return
	}
	defer outputImageFile.Close()

	switch strings.ToLower(*outputFormat) {
	case "jpeg", "jpg":
		err = jpeg.Encode(outputImageFile, inputImage, nil)
		break
	case "png":
		err = png.Encode(outputImageFile, inputImage)
		break
	default:
		fmt.Println("Unsupported output format")
		return
	}

	if err != nil {
		fmt.Println("Error encoding the output image:", err)
		return
	}

	fmt.Printf("Image converted successfully to %s\n", *outputFormat)

}

