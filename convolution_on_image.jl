### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 8585ad90-d99f-11eb-0782-8f1b33d43b4d
begin
    import Pkg
    # activate a clean environment
    Pkg.activate(mktempdir())

    Pkg.add(name="Images")
    Pkg.add(name="FileIO")

	using Images
	using FileIO
end

# ╔═╡ 0c8998d9-d8c1-40c3-b147-f44003fef025
begin
	url = "https://i.imgur.com/VGPeJ6s.jpg"
	download(url, "philip.jpg")
	philip = load("philip.jpg");
end

# ╔═╡ 03a8f21d-c985-49b2-9a5e-9bd4355b2d72
decimate(img, k) = img[1:k:end, 1:k:end]

# ╔═╡ 5e7d5bf3-147e-44d1-9c25-8e5a830087e2
poor_phil = decimate(philip, 8)

# ╔═╡ 64857813-e2f0-45f3-992c-e3cb55a1bfaf
function clamp_at_boundary(M, i, j)
	return M[
		clamp(i, 1, size(M, 1)),
		clamp(j, 1, size(M, 2)),	
	]
end

# ╔═╡ 568094ea-255d-4100-9c60-2641b78afddd
function convolve(M, kernel, M_index_func=clamp_at_boundary)
	size(M)
    height = size(kernel, 1)
    width = size(kernel, 2)
    
    half_height = height ÷ 2
    half_width = width ÷ 2
    println(size(M))
    new_image = similar(M)

	# (i, j) loop over the original image
    @inbounds for i in 1:size(M, 1)
        for j in 1:size(M, 2)
            # (k, l) loop over the neighbouring pixels
			new_image[i, j] = sum([
				kernel[k, l] * M_index_func(M, i - k, j - l)
				for k in -half_height:-half_height + height - 1
				for l in -half_width:-half_width + width - 1
			])
        end
    end
    
    return new_image
end

# ╔═╡ ece09f3d-9c33-486e-95b2-3a723ef27dc5
box_blur(n) = centered(ones(n, n) ./ (n^2))

# ╔═╡ f9bcaeea-6aaa-4ca2-9a33-f92dea365984
# convolve(poor_phil, box_blur(2))
size(poor_phil)

# ╔═╡ bae786fe-1bba-46e1-8728-778ad0bc349d
kernel = box_blur(5) # Kernel.gaussian((1, 0.1))

# ╔═╡ cb5a3e07-db6b-4751-9480-4f1c07ac7e95
sum(kernel)

# ╔═╡ cf71d105-e775-424f-9da8-9c552ede6fe7
convolve(poor_phil, kernel)

# ╔═╡ 2f573afa-0e25-453c-89ef-7e332252fe42


# ╔═╡ Cell order:
# ╠═8585ad90-d99f-11eb-0782-8f1b33d43b4d
# ╠═0c8998d9-d8c1-40c3-b147-f44003fef025
# ╠═5e7d5bf3-147e-44d1-9c25-8e5a830087e2
# ╟─03a8f21d-c985-49b2-9a5e-9bd4355b2d72
# ╟─64857813-e2f0-45f3-992c-e3cb55a1bfaf
# ╠═568094ea-255d-4100-9c60-2641b78afddd
# ╠═ece09f3d-9c33-486e-95b2-3a723ef27dc5
# ╠═f9bcaeea-6aaa-4ca2-9a33-f92dea365984
# ╠═bae786fe-1bba-46e1-8728-778ad0bc349d
# ╠═cb5a3e07-db6b-4751-9480-4f1c07ac7e95
# ╠═cf71d105-e775-424f-9da8-9c552ede6fe7
# ╠═2f573afa-0e25-453c-89ef-7e332252fe42
